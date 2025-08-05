//
//  GameScoringStageV1.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public enum GameScoringStageV1: String, Hashable, CaseIterable, RawRepresentable {
    case auto = "Auto"
    case teleop = "Teleop"

    public var timerStartStage: GameTimerV1.Stage {
        switch self {
        case .auto:
            .start
        case .teleop:
            .teleopJumpStart
        }
    }
}
