//
//  FTCSeason.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public enum FTCSeason: String, Codable, Sendable, RawRepresentable {
    case skystone = "SKYSTONE"
    case ultimateGoal = "ULTIMATE GOAL"
    case freightFrenzy = "FREIGHT FRENZY"
    case powerplay = "POWERPLAY"
    case centerstage = "CENTERSTAGE"
    case intoTheDeep = "INTO THE DEEP"
    case decode = "DECODE"

    var year: String {
        switch self {
        case .skystone:
            "2019"
        case .ultimateGoal:
            "2020"
        case .freightFrenzy:
            "2021"
        case .powerplay:
            "2022"
        case .centerstage:
            "2023"
        case .intoTheDeep:
            "2024"
        case .decode:
            "2025"
        }
    }

    var name: String {
        return self.rawValue
    }
}
