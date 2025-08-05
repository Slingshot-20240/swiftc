//
//  GameTimerTests.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/5/25.
//

import Foundation
import Testing

@testable import SwiFTC

@MainActor func log(v1Timer timer: GameTimerV1) {
    print(
        "\(timer.scoringStage.rawValue)\t  \(timer.timerStage)\("\(timer.timerStage)".count <= 8 ? "    \t\t" : "  \t")\(timer.countdown / 60):\(String(format: "%02d", timer.countdown % 60))    \tmuted:\(timer.muted)      \tinProgress:\(timer.inProgress)      \tpaused:\(timer.paused)"
    )
}

@Test @MainActor func v1StandardTest() async throws {
    let timer = GameTimerV1()

    timer.start()

    log(v1Timer: timer)

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        Task { @MainActor in
            log(v1Timer: timer)
        }
    }

    try await Task.sleep(for: .seconds(165))
}

@Test @MainActor func v1MutedTest() async throws {
    let timer = GameTimerV1()

    timer.start(mute: true)

    log(v1Timer: timer)

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        Task { @MainActor in
            log(v1Timer: timer)
        }
    }

    try await Task.sleep(for: .seconds(161))
}

@Test @MainActor func v1FromTeleopTest() async throws {
    let timer = GameTimerV1()

    timer.start(from: GameScoringStageV1.teleop.timerStartStage)

    log(v1Timer: timer)

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        Task { @MainActor in
            log(v1Timer: timer)
        }
    }

    try await Task.sleep(for: .seconds(127))
}

@Test @MainActor func v1PauseResumeTest() async throws {
    let timer = GameTimerV1()

    timer.start(from: GameScoringStageV1.teleop.timerStartStage)

    log(v1Timer: timer)

    let prePauseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
    { thisTimer in
        if thisTimer.isValid {
            Task { @MainActor in
                log(v1Timer: timer)
            }
        }
    }

    try await Task.sleep(for: .seconds(92))

    timer.pause()

    try await Task.sleep(for: .seconds(1))

    prePauseTimer.invalidate()

    try await Task.sleep(for: .seconds(2))

    timer.resume()

    log(v1Timer: timer)

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        Task { @MainActor in
            log(v1Timer: timer)
        }
    }

    try await Task.sleep(for: .seconds(35))
}
