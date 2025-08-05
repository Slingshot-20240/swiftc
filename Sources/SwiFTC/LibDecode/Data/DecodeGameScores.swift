//
//  DecodeGameScores.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct DecodeGameScores: Codable {
    var blue: AllianceScores
    var red: AllianceScores

    init() {
        self.blue = .init()
        self.red = .init()
    }

    struct AllianceScores: Codable {
        var auto: StageScores
        var teleop: StageScores
        var minorFoulsFromOtherAllianceAwarded: Int
        var majorFoulsFromOtherAllianceAwarded: Int

        init() {
            self.auto = .init()
            self.teleop = .init()
            self.minorFoulsFromOtherAllianceAwarded = 0
            self.majorFoulsFromOtherAllianceAwarded = 0
        }

        struct StageScores: Codable {
            var gameElementZone0: Int
            var gameElementZone1: Int
            var team1Location: Location
            var team2Location: Location

            init() {
                self.gameElementZone0 = 0
                self.gameElementZone1 = 0
                self.team1Location = .none
                self.team2Location = .none
            }

            enum Location: String, Codable, RawRepresentable {
                case none = "None"

                var autoDescription: String {
                    self.rawValue
                }

                var teleopDescription: String {
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

                var icon: String {
                    switch self {
                    case .none:
                        "nosign"
                    }
                }

                var points: Int {
                    switch self {
                    case .none:
                        0
                    }
                }
            }

            var total: Int {
                return self.gameElementZone0 * 0
                    + self.gameElementZone1 * 0
                    + self.team1Location.points
                    + self.team2Location.points
            }
        }

        var foulPointsFromOtherAllianceAwarded: Int {
            return self.minorFoulsFromOtherAllianceAwarded * 5 + self
                .majorFoulsFromOtherAllianceAwarded * 15
        }

        var total: Int {
            return self.auto.total + self.teleop.total
                + self.foulPointsFromOtherAllianceAwarded
        }
    }

    var total: Int {
        return self.blue.total + self.red.total
    }
}
