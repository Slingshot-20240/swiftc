//
//  DecodeGameScores.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct DecodeGameScores: Codable {
    public var blue: AllianceScores
    public var red: AllianceScores

    public init() {
        self.blue = .init()
        self.red = .init()
    }

    public struct AllianceScores: Codable {
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

        public struct StageScores: Codable {
            public var gameElementZone0: Int
            public var gameElementZone1: Int
            public var team1Location: Location
            public var team2Location: Location

            public init() {
                self.gameElementZone0 = 0
                self.gameElementZone1 = 0
                self.team1Location = .none
                self.team2Location = .none
            }

            public enum Location: String, Codable, RawRepresentable {
                case none = "None"

                public var autoDescription: String {
                    self.rawValue
                }

                public var teleopDescription: String {
                    switch self {
                    default:
                        self.rawValue
                    }
                }

                func description(_ stage: GameScoringStageV1) -> String {
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
                    }
                }

                public var points: Int {
                    switch self {
                    case .none:
                        0
                    }
                }
            }

            public var total: Int {
                return self.gameElementZone0 * 0
                    + self.gameElementZone1 * 0
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
