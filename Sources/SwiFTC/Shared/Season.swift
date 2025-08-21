//
//  Season.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public enum FIRSTSeason: String, Codable, Hashable, Sendable, RawRepresentable {
    case rise = "RISE"
    case gameChangers = "GAME CHANGERS"
    case forward = "FORWARD"
    case energize = "ENERGIZE"
    case inShow = "IN SHOW"
    case dive = "DIVE"
    case age = "AGE"

    public var name: String {
        self.rawValue
    }

    public var year: String {
        String(self._year)
    }

    private var _year: Int {
        switch self {
        case .rise:
            2019
        case .gameChangers:
            2020
        case .forward:
            2021
        case .energize:
            2022
        case .inShow:
            2023
        case .dive:
            2024
        case .age:
            2025
        }
    }

    public var nameWithTrademark: String {
        self.name + (self._year >= 2025 ? "™" : "℠")
    }

    public var nameWithMarkdownStylizedFirstWordMarkAndTrademark: String {
        "*FIRST*® " + self.nameWithTrademark
    }

    public var ftcSeason: FTCSeason {
        switch self {
        case .rise:
            .skystone
        case .gameChangers:
            .ultimateGoal
        case .forward:
            .freightFrenzy
        case .energize:
            .powerplay
        case .inShow:
            .centerstage
        case .dive:
            .intoTheDeep
        case .age:
            .decode
        }
    }
}

public enum FTCSeason: String, Codable, Hashable, Sendable, RawRepresentable {
    case skystone = "SKYSTONE"
    case ultimateGoal = "ULTIMATE GOAL"
    case freightFrenzy = "FREIGHT FRENZY"
    case powerplay = "POWERPLAY"
    case centerstage = "CENTERSTAGE"
    case intoTheDeep = "INTO THE DEEP"
    case decode = "DECODE"

    public var name: String {
        return self.rawValue
    }

    public var year: String {
        String(self._year)
    }

    private var _year: Int {
        switch self {
        case .skystone:
            2019
        case .ultimateGoal:
            2020
        case .freightFrenzy:
            2021
        case .powerplay:
            2022
        case .centerstage:
            2023
        case .intoTheDeep:
            2024
        case .decode:
            2025
        }
    }

    public var nameWithTrademark: String {
        self.name + (self._year >= 2025 ? "™" : "℠")
    }

    public var firstSeason: FIRSTSeason {
        switch self {
        case .skystone:
            .rise
        case .ultimateGoal:
            .gameChangers
        case .freightFrenzy:
            .forward
        case .powerplay:
            .energize
        case .centerstage:
            .inShow
        case .intoTheDeep:
            .dive
        case .decode:
            .age
        }
    }
}
