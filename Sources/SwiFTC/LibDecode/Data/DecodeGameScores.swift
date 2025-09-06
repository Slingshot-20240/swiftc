//
//  DecodeGameScores.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct DecodeGameScores: Codable, Hashable {
    public var blue: AllianceScores
    public var red: AllianceScores

    public init() {
        self.blue = .init()
        self.red = .init()
    }

    public struct AllianceScores: Codable, Hashable {
        public var auto: AutoScores
        public var teleop: TeleopScores
        public var minorFoulsFromOtherAllianceAwarded: Int
        public var majorFoulsFromOtherAllianceAwarded: Int

        public init() {
            self.auto = .init()
            self.teleop = .init()
            self.minorFoulsFromOtherAllianceAwarded = 0
            self.majorFoulsFromOtherAllianceAwarded = 0
        }

        public struct AutoScores: Codable, Hashable {
            public var classfied: Int
            public var overflown: Int
            public var matchingMotifs: Int

            public var team1Location: Location
            public var team2Location: Location

            public init() {
                self.classfied = 0
                self.overflown = 0
                self.matchingMotifs = 0
                self.team1Location = .none
                self.team2Location = .none
            }

            public enum Location: String, Codable, Hashable, RawRepresentable {
                case none = "None"
                case leave = "Leave"

                public var description: String {
                    self.rawValue
                }

                public var icon: String {
                    switch self {
                    case .none:
                        "nosign"
                    case .leave:
                        "rectangle.portrait.and.arrow.forward"
                    }
                }

                public var points: Int {
                    switch self {
                    case .none:
                        0
                    case .leave:
                        3
                    }
                }
            }

            public var total: Int {
                self.classfied * 3
                    + self.overflown * 1
                    + self.matchingMotifs * 2
                    + self.team1Location.points
                    + self.team2Location.points
            }
        }

        public struct TeleopScores: Codable, Hashable {
            public var classfied: Int
            public var overflown: Int
            public var depot: Int
            public var matchingMotifs: Int

            public var team1Location: Location
            public var team2Location: Location

            public init() {
                self.classfied = 0
                self.overflown = 0
                self.depot = 0
                self.matchingMotifs = 0
                self.team1Location = .none
                self.team2Location = .none
            }

            public enum Location: String, Codable, Hashable, RawRepresentable {
                case none = "None"
                case partial = "Partial"
                case full = "Full"

                public var description: String {
                    self.rawValue
                }

                public var icon: String {
                    switch self {
                    case .none:
                        "nosign"
                    case .partial:
                        "square.dashed"
                    case .full:
                        "square"
                    }
                }

                public var points: Int {
                    switch self {
                    case .none:
                        0
                    case .partial:
                        5
                    case .full:
                        10
                    }
                }
            }

            public var total: Int {
                self.classfied * 3
                    + self.overflown * 1
                    + self.depot * 1
                    + self.matchingMotifs * 2
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
