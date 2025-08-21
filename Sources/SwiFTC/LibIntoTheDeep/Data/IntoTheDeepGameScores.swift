//
//  IntoTheDeepGameScores.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct IntoTheDeepGameScores: Codable, Hashable {
    public var blue: AllianceScores
    public var red: AllianceScores

    public init() {
        self.blue = .init()
        self.red = .init()
    }

    public struct AllianceScores: Codable, Hashable {
        public var auto: StageScores
        public var teleop: StageScores
        public var minorFoulsFromOtherAllianceAwarded: Int
        public var majorFoulsFromOtherAllianceAwarded: Int

        public init() {
            self.auto = .init()
            self.teleop = .init()
            self.minorFoulsFromOtherAllianceAwarded = 0
            self.majorFoulsFromOtherAllianceAwarded = 0
        }

        public struct StageScores: Codable, Hashable {
            public var samplesNet: Int
            public var samplesLow: Int
            public var samplesHigh: Int
            public var specimenLow: Int
            public var specimenHigh: Int
            public var team1Location: Location
            public var team2Location: Location

            public init() {
                self.samplesNet = 0
                self.samplesLow = 0
                self.samplesHigh = 0
                self.specimenLow = 0
                self.specimenHigh = 0
                self.team1Location = .none
                self.team2Location = .none
            }

            public enum Location: String, Codable, Hashable, RawRepresentable {
                case none = "None"
                case oZone = "Observation Zone"
                case aZone = "Ascent Zone"
                case l2 = "Level 2"
                case l3 = "Level 3"

                public var autoDescription: String {
                    self.rawValue
                }

                public var teleopDescription: String {
                    switch self {
                    case .oZone:
                        "O-Zone"
                    case .aZone:
                        "Level 1"
                    default:
                        self.rawValue
                    }
                }

                public func description(_ stage: GameScoringStageV1) -> String {
                    switch stage {
                    case .auto:
                        return self.autoDescription
                    case .teleop:
                        return self.teleopDescription
                    }
                }

                public var icon: String {
                    switch self {
                    case .none:
                        "nosign"
                    case .oZone:
                        "eyeglasses"
                    case .aZone:
                        "hexagon.bottomhalf.filled"
                    case .l2:
                        "chevron.compact.up"
                    case .l3:
                        "chevron.up"
                    }
                }

                public var points: Int {
                    switch self {
                    case .none:
                        0
                    case .oZone:
                        3
                    case .aZone:
                        3
                    case .l2:
                        15
                    case .l3:
                        30
                    }
                }
            }

            public var total: Int {
                return self.samplesNet * 2
                    + self.samplesLow * 4
                    + self.samplesHigh * 8
                    + self.specimenLow * 6
                    + self.specimenHigh * 10
                    + self.team1Location.points
                    + self.team2Location.points
            }
        }

        public var foulPointsFromOtherAllianceAwarded: Int {
            return self.minorFoulsFromOtherAllianceAwarded * 5 + self
                .majorFoulsFromOtherAllianceAwarded * 15
        }

        public var total: Int {
            return self.auto.total + self.teleop.total
                + self.foulPointsFromOtherAllianceAwarded
        }
    }

    public var total: Int {
        return self.blue.total + self.red.total
    }
}
