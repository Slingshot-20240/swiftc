//
//  DecodeGameScores.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct DecodeGameScores: SwiFTCDataConformable {
    public var blue: AllianceScores
    public var red: AllianceScores
    public var motif: Motif?

    public init() {
        self.blue = .init()
        self.red = .init()
        self.motif = nil
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
            public var motifs: Motifs?

            public var team1Location: Location
            public var team2Location: Location

            public init() {
                self.classfied = 0
                self.overflown = 0
                self.matchingMotifs = 0
                self.motifs = nil
                self.team1Location = .none
                self.team2Location = .none
            }

            public enum Location: String, Codable, Hashable, RawRepresentable {
                case none = "None"
                case left = "Left"

                public var description: String {
                    self.rawValue
                }

                public var icon: String {
                    switch self {
                    case .none:
                        "nosign"
                    case .left:
                        "rectangle.portrait.and.arrow.forward"
                    }
                }

                public var points: Int {
                    switch self {
                    case .none:
                        0
                    case .left:
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
            public var motifs: Motifs?

            public var team1Location: Location
            public var team2Location: Location

            public init() {
                self.classfied = 0
                self.overflown = 0
                self.depot = 0
                self.matchingMotifs = 0
                self.motifs = nil
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
                        "square.fill"
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
                    + (self.team1Location == .full
                        && self.team2Location == .full ? 10 : 0)
            }
        }

        public struct Motifs: Codable, Hashable {
            public var p1: Artifact?
            public var p2: Artifact?
            public var p3: Artifact?
            public var p4: Artifact?
            public var p5: Artifact?
            public var p6: Artifact?
            public var p7: Artifact?
            public var p8: Artifact?
            public var p9: Artifact?

            public enum Artifact: String, Codable, Hashable {
                case green = "Green"
                case purple = "Purple"
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

        public var totalNf: Int {
            return self.auto.total + self.teleop.total
        }
    }

    public enum Motif: Int, Codable, Hashable {
        case gpp = 21
        case pgp = 22
        case ppg = 23
    }

    public var total: Int {
        return self.blue.total + self.red.total
    }
}
