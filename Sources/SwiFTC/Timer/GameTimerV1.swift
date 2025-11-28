//
//  GameTimerV1.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import AVFoundation
import Foundation

@MainActor public class GameTimerV1: ObservableObject {
    public static var shared: GameTimerV1 = .init()

    var timer: Timer?

    @Published public var timerStage: Stage
    @Published public var countdown: Int
    @Published public var paused: Bool
    @Published public var scoringStage: GameScoringStageV1

    let endgameStartSecondsAfterTeleop: TimeInterval

    public var muted: Bool
    let countdownAudio: AVAudioPlayer
    let startAudio: AVAudioPlayer
    let transitionAudio: AVAudioPlayer
    let pickupAudio: AVAudioPlayer
    let teleopAudio: AVAudioPlayer
    let endgameAudio: AVAudioPlayer
    let endAudio: AVAudioPlayer

    public init(
        timer: Timer? = nil,
        timerStage: Stage = .standby,
        countdown: Int = 3,
        paused: Bool = false,
        scoringStage: GameScoringStageV1 = .auto,
        endgameStartSecondsAfterTeleop: TimeInterval = 100
    ) {
        self.timer = timer
        self.timerStage = timerStage
        self.countdown = countdown
        self.paused = paused
        self.scoringStage = scoringStage

        self.endgameStartSecondsAfterTeleop = endgameStartSecondsAfterTeleop

        func audioPlayer(for name: String) -> AVAudioPlayer {
            let url = URL(
                fileURLWithPath: Bundle.module.path(
                    forResource: "\(name).wav",
                    ofType: nil
                )!
            )

            return (try? AVAudioPlayer(contentsOf: url))
                ?? (try! AVAudioPlayer(data: .init()))
        }

        self.muted = false
        self.countdownAudio = audioPlayer(for: "countdown")
        self.countdownAudio.prepareToPlay()
        self.startAudio = audioPlayer(for: "start")
        self.startAudio.prepareToPlay()
        self.transitionAudio = audioPlayer(for: "transition")
        self.transitionAudio.prepareToPlay()
        self.pickupAudio = audioPlayer(for: "pickup")
        self.pickupAudio.prepareToPlay()
        self.teleopAudio = audioPlayer(for: "teleop")
        self.teleopAudio.prepareToPlay()
        self.endgameAudio = audioPlayer(for: "endgame")
        self.endgameAudio.prepareToPlay()
        self.endAudio = audioPlayer(for: "end")
        self.endAudio.prepareToPlay()
    }

    public enum Stage {
        case standby, start, auto, transition, teleopJumpStart, teleop, finished

        public enum AdvancementError: Error {
            case atFinalStage

            var description: String {
                switch self {
                case .atFinalStage:
                    return "Timer is already at the final stage."
                }
            }
        }

        public var startSeconds: Int {
            switch self {
            case .start, .teleopJumpStart:
                3
            case .auto:
                30
            case .transition:
                8
            case .teleop:
                120
            default:
                0
            }
        }

        public mutating func advance() throws -> Int {
            switch self {
            case .standby:
                self = .start
            case .start:
                self = .auto
            case .auto:
                self = .transition
            case .transition, .teleopJumpStart:
                self = .teleop
            case .teleop:
                self = .finished
            case .finished:
                throw AdvancementError.atFinalStage
            }

            return self.startSeconds
        }
    }

    public var inProgress: Bool {
        self.timer != nil && ![.standby, .finished].contains(self.timerStage)
    }

    public func start(from stage: Stage = .start, mute: Bool = false) {
        self.reset()
        self.muted = mute
        self.timerStage = stage
        self._startTimer()

        if !mute {
            self.countdownAudio.play()
        }
    }

    public func pause() {
        self.timer?.invalidate()
        self.paused = !(self.timer?.isValid ?? true)

        self.countdownAudio.pause()
        self.startAudio.pause()
        self.transitionAudio.pause()
        self.pickupAudio.pause()
        self.teleopAudio.pause()
        self.endgameAudio.pause()
        self.endAudio.pause()
    }

    public func resume() {
        if self.paused {
            self._startTimer()

            if !self.muted {
                self.teleopAudio.currentTime = 0
                self.teleopAudio.play()
            }
        }
    }

    private func _startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            _ in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.countdown -= 1

                if self.countdown <= 0 {
                    do {
                        self.countdown = try self.timerStage.advance()
                        if self.timerStage == .teleop {
                            self.scoringStage = .teleop
                        }

                        if !self.muted {
                            switch self.timerStage {
                            case .auto:
                                self.startAudio.play()
                            case .transition:
                                self.transitionAudio.play()

                                Timer.scheduledTimer(
                                    withTimeInterval: 2,
                                    repeats: false
                                ) { _ in
                                    Task { @MainActor [weak self] in
                                        guard let self else { return }
                                        if self.timer?.isValid ?? false {
                                            self.pickupAudio.play()
                                        }

                                        Timer.scheduledTimer(
                                            withTimeInterval: 2.7,
                                            repeats: false
                                        ) { _ in
                                            Task { @MainActor [weak self] in
                                                guard let self else { return }
                                                if self.timer?.isValid ?? false
                                                {
                                                    self.countdownAudio
                                                        .currentTime = 0
                                                    self.countdownAudio.play()
                                                }
                                            }
                                        }
                                    }
                                }
                            case .teleop:
                                self.teleopAudio.currentTime = 0
                                self.teleopAudio.play()

                                Timer.scheduledTimer(
                                    withTimeInterval: self
                                        .endgameStartSecondsAfterTeleop,
                                    repeats: false
                                ) { _ in
                                    Task { @MainActor [weak self] in
                                        guard let self else { return }
                                        if self.timer?.isValid ?? false {
                                            self.endgameAudio.play()
                                        }
                                    }
                                }
                            case .finished:
                                self.endAudio.play()
                            default:
                                break
                            }
                        }

                        if self.timerStage == .finished {
                            self.timer?.invalidate()
                            self.timer = nil
                        }
                    } catch {
                        self.timer?.invalidate()
                        self.timer = nil
                        return
                    }
                }
            }
        }

        if let timer {
            RunLoop.current.add(timer, forMode: .common)
        }

        self.paused = !(self.timer?.isValid ?? true)
    }

    public func reset() {
        self.timer?.invalidate()
        self.timer = nil
        self.timerStage = .standby
        self.countdown = 3
        self.paused = false
        self.scoringStage = .auto
        self.muted = true
        self.countdownAudio.pause()
        self.countdownAudio.currentTime = 0
        self.startAudio.pause()
        self.startAudio.currentTime = 0
        self.transitionAudio.pause()
        self.transitionAudio.currentTime = 0
        self.pickupAudio.pause()
        self.pickupAudio.currentTime = 0
        self.teleopAudio.pause()
        self.teleopAudio.currentTime = 0
        self.endgameAudio.pause()
        self.endgameAudio.currentTime = 0
        self.endAudio.pause()
        self.endAudio.currentTime = 0
    }
}
