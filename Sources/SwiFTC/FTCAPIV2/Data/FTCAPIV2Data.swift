//
//  FTCAPIV2Data.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct FTCAPIV2Data {
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .custom { decoder in
            let iso8601Formatter = ISO8601DateFormatter()
            iso8601Formatter.formatOptions = [
                .withInternetDateTime, .withFractionalSeconds,
            ]

            let localWithMillisFormatter = DateFormatter()
            localWithMillisFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            localWithMillisFormatter.timeZone = TimeZone(identifier: "UTC")

            let localNoMillisFormatter = DateFormatter()
            localNoMillisFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            localNoMillisFormatter.timeZone = TimeZone(identifier: "UTC")

            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = iso8601Formatter.date(from: dateString) {
                return date
            } else if let date = localWithMillisFormatter.date(from: dateString)
            {
                return date
            } else if let date = localNoMillisFormatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription:
                        "Cannot decode date string \(dateString) to any of the expected formats."
                )
            }
        }

        return decoder
    }

    public static func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T
    {
        return try Self.decoder.decode(type, from: data)
    }

    public struct APIIndex: SwiFTCDataConformable {
        public let name: String?
        public let apiName: String?
        public let apiVersion: String?
        public let serviceMainifestName: String?
        public let serviceMainifestVersion: String?
        public let codePackageName: String?
        public let codePackageVersion: String?
        public let status: String?
        public let currentSeason: Int
        public let maxSeason: Int
    }

    public struct SeasonSummary: SwiFTCDataConformable {
        public let eventCount: Int
        public let gameName: String?
        public let kickoff: Date?
        public let rookieStart: Int
        public let teamCount: Int
        public let frcChampionships: [ChampionshipDescription]?

        public struct ChampionshipDescription: SwiFTCDataConformable {
            public let name: String?
            public let startDate: Date?
            public let location: String?
        }
    }

    public struct LeagueListings: SwiFTCDataConformable {
        public let leagues: [League]?
        public let leagueCount: Int

        public struct League: SwiFTCDataConformable {
            public let region: String?
            public let code: String?
            public let name: String?
            public let remote: Bool?
            public let parentLeagueCode: String?
            public let parentLeagueName: String?
            public let location: String?
        }
    }

    public struct LeagueMembership: SwiFTCDataConformable {
        public let members: [Int]?
    }

    public struct LeagueRankings: SwiFTCDataConformable {
        public let rankings: [TeamRanking]?
    }

    public struct TeamListings: SwiFTCDataConformable {
        public let teams: [Team]?
        public let teamCountTotal: Int
        public let teamCountPage: Int
        public let pageCurrent: Int
        public let pageTotal: Int

        public struct Team: SwiFTCDataConformable {
            public let teamNumber: Int
            public let displayTeamNumber: String?
            public let nameFull: String?
            public let nameShort: String?
            public let schoolName: String?
            public let city: String?
            public let stateProv: String?
            public let country: String?
            public let website: String?
            public let rookieYear: Int?
            public let robotName: String?
            public let districtCode: String?
            public let homeCMP: String?
            public let homeRegion: String?
            public let displayLocation: String?
        }
    }

    public struct EventListings: SwiFTCDataConformable {
        public let events: [EventListings.Event]?
        public let eventCount: Int

        public struct Event: SwiFTCDataConformable {
            public let eventId: String
            public let code: String?
            public let divisionCode: String?
            public let name: String?
            public let remote: Bool
            public let hybrid: Bool
            public let fieldCount: Int
            public let published: Bool
            public let type: String?
            public let typeName: String?
            public let regionCode: String?
            public let leagueCode: String?
            public let districtCode: String?
            public let venue: String?
            public let address: String?
            public let city: String?
            public let stateprov: String?
            public let country: String?
            public let website: String?
            public let liveStreamUrl: String?
            public let coordinates: Coordinates?
            public let webcasts: [String]?
            public let timezone: String?
            public let dateStart: Date
            public let dateEnd: Date

            public struct Coordinates: SwiFTCDataConformable {
                public let type: String
                public let coordinates: [Double]
            }
        }
    }

    public struct HybridSchedule: SwiFTCDataConformable {
        public let schedule: [Match]?

        public struct Match: SwiFTCDataConformable {
            public let description: String?
            public let tournamentLevel: TournamentLevel?
            public let series: Int
            public let matchNumber: Int
            public let startTime: Date?
            public let actualStartTime: Date?
            public let postResultTime: Date?
            public let scoreRedFinal: Int?
            public let scoreRedFoul: Int?
            public let scoreRedAuto: Int?
            public let scoreBlueFinal: Int?
            public let scoreBlueFoul: Int?
            public let scoreBlueAuto: Int?
            public let scoreBlueDriveControlled: Int?
            public let scoreBlueEndgame: Int?
            public let redWins: Bool?
            public let blueWins: Bool?
            public let teams: [Team]?

            public struct Team: SwiFTCDataConformable {
                public let teamNumber: Int?
                public let displayTeamNumber: String?
                public let station: String?
                public let surrogate: Bool
                public let noShow: Bool
                public let dq: Bool?
                public let onField: Bool?
                public let teamName: String?
            }
        }
    }

    public struct EventSchedule: SwiFTCDataConformable {
        public let schedule: [ScheduledMatch]?

        public struct ScheduledMatch: SwiFTCDataConformable {
            public let description: String?
            public let field: String?
            public let tournamentLevel: TournamentLevel?
            public let startTime: Date?
            public let series: Int
            public let matchNumber: Int
            public let teams: [Team]?
            public let modifiedOn: Date?

            public struct Team: SwiFTCDataConformable {
                public let teamNumber: Int?
                public let displayTeamNumber: String?
                public let station: String?
                public let team: String?
                public let teamName: String?
                public let surrogate: Bool
                public let noShow: Bool
            }
        }
    }

    public struct EventRankings: SwiFTCDataConformable {
        public let rankings: [TeamRanking]?
    }

    public struct EventAlliances: SwiFTCDataConformable {
        public let alliances: [Alliance]?
        public let count: Int

        public struct Alliance: SwiFTCDataConformable {
            public let number: Int
            public let name: String?
            public let captain: Int?
            public let captainDisplay: String?
            public let round1: Int?
            public let round1Display: String?
            public let round2: Int?
            public let round2Display: String?
            public let round3: Int?
            public let backup: Int?
            public let backupReplaced: Int?
        }
    }

    public struct EventMatchResults: SwiFTCDataConformable {
        public let matches: [MatchResult]?

        public struct MatchResult: SwiFTCDataConformable {
            public let actualStartTime: String?
            public let description: String?
            public let tournamentLevel: TournamentLevel?
            public let series: Int
            public let matchNumber: Int
            public let scoreRedFinal: Int
            public let scoreRedFoul: Int
            public let scoreRedAuto: Int
            public let scoreBlueFinal: Int
            public let scoreBlueFoul: Int
            public let scoreBlueAuto: Int
            public let postResultTime: String?
            public let teams: [Team]?
            public let modifiedOn: String?

            public struct Team: SwiFTCDataConformable {
                public let teamNumber: Int
                public let station: String?
                public let dq: Bool
                public let onField: Bool
            }
        }
    }

    public enum AnyScoreDetails {
        static func decode(
            for season: FTCSeason,
            from data: Data
        ) throws -> AnyScoreDetails {
            let decoder = FTCAPIV2Data.decoder

            switch season {
            case .skystone:
                return .skystone(
                    try decoder.decode(
                        ScoreDetails<Skystone>.self,
                        from: data
                    )
                )
            case .ultimateGoal:
                if let scoreDetails = try? decoder.decode(
                    ScoreDetails<UltimateGoal.Alliance>.self,
                    from: data
                ) {
                    return .ultimateGoalAlliance(scoreDetails)
                }

                return .ultimateGoalSingleTeam(
                    try decoder.decode(
                        ScoreDetails<UltimateGoal.SingleTeam>.self,
                        from: data
                    )
                )
            case .freightFrenzy:
                if let scoreDetails = try? decoder.decode(
                    ScoreDetails<FreightFrenzy.Alliance>.self,
                    from: data
                ) {
                    return .freightFrenzyAlliance(scoreDetails)
                }

                return .freightFrenzySingleTeam(
                    try decoder.decode(
                        ScoreDetails<FreightFrenzy.SingleTeam>.self,
                        from: data
                    )
                )
            case .powerplay:
                if let scoreDetails = try? decoder.decode(
                    ScoreDetails<Powerplay.Alliance>.self,
                    from: data
                ) {
                    return .powerplayAlliance(scoreDetails)
                }

                return .powerplaySingleTeam(
                    try decoder.decode(
                        ScoreDetails<Powerplay.SingleTeam>.self,
                        from: data
                    )
                )
            case .centerstage:
                if let scoreDetails = try? decoder.decode(
                    ScoreDetails<Centerstage.Alliance>.self,
                    from: data
                ) {
                    return .centerstageAlliance(scoreDetails)
                }

                return .centerstageSingleTeam(
                    try decoder.decode(
                        ScoreDetails<Centerstage.SingleTeam>.self,
                        from: data
                    )
                )
            case .intoTheDeep:
                return .intoTheDeep(
                    try decoder.decode(
                        ScoreDetails<IntoTheDeep>.self,
                        from: data
                    )
                )
            case .decode:
                fatalError(
                    "The DECODE™ season score details are not yet implemented."
                )
            }
        }

        case skystone(ScoreDetails<Skystone>)
        case ultimateGoalAlliance(ScoreDetails<UltimateGoal.Alliance>)
        case ultimateGoalSingleTeam(ScoreDetails<UltimateGoal.SingleTeam>)
        case freightFrenzyAlliance(ScoreDetails<FreightFrenzy.Alliance>)
        case freightFrenzySingleTeam(ScoreDetails<FreightFrenzy.SingleTeam>)
        case powerplayAlliance(ScoreDetails<Powerplay.Alliance>)
        case powerplaySingleTeam(ScoreDetails<Powerplay.SingleTeam>)
        case centerstageAlliance(ScoreDetails<Centerstage.Alliance>)
        case centerstageSingleTeam(ScoreDetails<Centerstage.SingleTeam>)
        case intoTheDeep(ScoreDetails<IntoTheDeep>)

        public struct Skystone: MatchScoreDetailsItem, Codable, Hashable {
            public let matchLevel: FTCEventLevel
            public let matchSeries: Int
            public let matchNumber: Int
            public let alliances: [AllianceScores]?

            public struct AllianceScores: SwiFTCDataConformable {
                public let alliance: String?
                public let robot1Navigated: Bool
                public let robot1Parked: Bool
                public let robot1CapstoneLevel: Int
                public let robot2Navigated: Bool
                public let robot2Parked: Bool
                public let robot2CapstoneLevel: Int
                public let autoStones: [Stone]?
                public let autoDelivered: Int
                public let autoReturned: Int
                public let firstReturnedIsSkystone: Bool
                public let autoPlaced: Int
                public let foundationRepositioned: Bool
                public let foundationMoved: Bool
                public let driverControlledDelivered: Int
                public let driverControlledReturned: Int
                public let driverControlledPlaced: Int
                public let tallestSkyscraper: Int
                public let autoDeliveryPoints: Int
                public let autoPlacedPoints: Int
                public let autonomousPoints: Int
                public let repositionedPoints: Int
                public let navigationPoints: Int
                public let driverControlledDeliveryPoints: Int
                public let driverControlledPlacedPoints: Int
                public let skyscraperBonusPoints: Int
                public let capstonePoints: Int
                public let driverControlledPoints: Int
                public let parkingPoints: Int
                public let endGamePoints: Int
                public let minorPenalties: Int
                public let majorPenalties: Int
                public let penaltyPoints: Int
                public let totalPoints: Int
            }

            public enum Stone: String, Codable, Hashable {
                case none = "NONE"
                case stone = "STONE"
                case skystone = "SKYSTONE"
            }
        }

        public struct UltimateGoal {
            public struct Alliance: MatchScoreDetailsItem, Codable, Hashable {
                public let matchLevel: FTCEventLevel
                public let matchSeries: Int
                public let matchNumber: Int
                public let alliances: [AllianceScores]?

                public struct AllianceScores: SwiFTCDataConformable {
                    public let adjust: Int
                    public let dcPoints: Int
                    public let autoPoints: Int
                    public let dcTowerLow: Int
                    public let dcTowerMid: Int
                    public let dcTowerHigh: Int
                    public let navigated1: Bool
                    public let navigated2: Bool
                    public let wobbleDelivered1: Bool
                    public let wobbleDelivered2: Bool
                    public let autoTowerLow: Int
                    public let autoTowerMid: Int
                    public let autoTowerHigh: Int
                    public let autoTowerPoints: Int
                    public let autoPowerShotLeft: Bool
                    public let autoPowerShotCenter: Bool
                    public let autoPowerShotRight: Bool
                    public let autoPowerShotPoints: Int
                    public let wobbleRings1: Int
                    public let wobbleRings2: Int
                    public let wobbleEnd1: Int
                    public let wobbleEnd2: Int
                    public let wobbleEndPoints: Int
                    public let wobbleRingPoints: Int
                    public let autoWobblePoints: Int
                    public let endPowerShotLeft: Bool
                    public let endPowerShotCenter: Bool
                    public let endPowerShotRight: Bool
                    public let endPowerShotPoints: Int
                    public let penaltyPoints: Int
                    public let majorPenalties: Int
                    public let minorPenalties: Int
                    public let navigationPoints: Int
                    public let endgamePoints: Int
                    public let totalPoints: Int
                    public let alliance: String?
                    public let team: Int
                }
            }

            public struct SingleTeam: MatchScoreDetailsItem, Codable, Hashable {
                public let matchLevel: FTCEventLevel
                public let matchNumber: Int
                public let teamNumber: Int
                public let scores: Scores

                public struct Scores: SwiFTCDataConformable {
                    public let adjust: Int
                    public let dcPoints: Int
                    public let autoPoints: Int
                    public let dcTowerLow: Int
                    public let dcTowerMid: Int
                    public let dcTowerHigh: Int
                    public let navigated1: Bool
                    public let navigated2: Bool
                    public let wobbleDelivered1: Bool
                    public let wobbleDelivered2: Bool
                    public let autoTowerLow: Int
                    public let autoTowerMid: Int
                    public let autoTowerHigh: Int
                    public let autoTowerPoints: Int
                    public let autoPowerShotLeft: Bool
                    public let autoPowerShotCenter: Bool
                    public let autoPowerShotRight: Bool
                    public let autoPowerShotPoints: Int
                    public let wobbleRings1: Int
                    public let wobbleRings2: Int
                    public let wobbleEnd1: Int
                    public let wobbleEnd2: Int
                    public let wobbleEndPoints: Int
                    public let wobbleRingPoints: Int
                    public let autoWobblePoints: Int
                    public let endPowerShotLeft: Bool
                    public let endPowerShotCenter: Bool
                    public let endPowerShotRight: Bool
                    public let endPowerShotPoints: Int
                    public let penaltyPoints: Int
                    public let majorPenalties: Int
                    public let minorPenalties: Int
                    public let navigationPoints: Int
                    public let endgamePoints: Int
                    public let totalPoints: Int
                }
            }
        }

        public struct FreightFrenzy {
            public struct Alliance: MatchScoreDetailsItem, Codable, Hashable {
                public let matchLevel: FTCEventLevel
                public let matchSeries: Int
                public let matchNumber: Int
                public let randomization: Int
                public let alliances: [AllianceScores]?

                public struct AllianceScores: SwiFTCDataConformable {
                    public let alliance: String?
                    public let barcodeElement1: BarcodeElement
                    public let barcodeElement2: BarcodeElement
                    public let carousel: Bool
                    public let autoNavigated1: AutoNavigatedStatus
                    public let autoNavigated2: AutoNavigatedStatus
                    public let autoBonus1: Bool
                    public let autoBonus2: Bool
                    public let autoStorageFreight: Int
                    public let autoFreight1: Int
                    public let autoFreight2: Int
                    public let autoFreight3: Int
                    public let driverControlledStorageFreight: Int
                    public let driverControlledFreight1: Int
                    public let driverControlledFreight2: Int
                    public let driverControlledFreight3: Int
                    public let sharedFreight: Int
                    public let endgameDelivered: Int
                    public let allianceBalanced: Bool
                    public let sharedUnbalanced: Bool
                    public let endgameParked1: EndgameParkedStatus
                    public let endgameParked2: EndgameParkedStatus
                    public let capped: Int
                    public let minorPenalties: Int
                    public let majorPenalties: Int
                    public let carouselPoints: Int
                    public let autoNavigationPoints: Int
                    public let autoFreightPoints: Int
                    public let autoBonusPoints: Int
                    public let driverControlledAllianceHubPoints: Int
                    public let driverControlledSharedHubPoints: Int
                    public let driverControlledStoragePoints: Int
                    public let endgameDeliveryPoints: Int
                    public let allianceBalancedPoints: Int
                    public let sharedUnbalancedPoints: Int
                    public let endgameParkingPoints: Int
                    public let cappingPoints: Int
                    public let autoPoints: Int
                    public let driverControlledPoints: Int
                    public let endgamePoints: Int
                    public let penaltyPoints: Int
                    public let totalPoints: Int
                }
            }

            public struct SingleTeam: MatchScoreDetailsItem, Codable, Hashable {
                public var matchLevel: FTCEventLevel
                public var matchNumber: Int
                public var randomization: Int
                public var teamNumber: Int
                public var scores: Scores

                public struct Scores: SwiFTCDataConformable {
                    public var barcodeElement: BarcodeElement
                    public var carousel: Bool
                    public var autoNavigated: AutoNavigatedStatus
                    public var autoBonus: Bool
                    public var autoStorageFreight: Int
                    public var autoFreight1: Int
                    public var autoFreight2: Int
                    public var autoFreight3: Int
                    public var driverControlledStorageFreight: Int
                    public var driverControlledFreight1: Int
                    public var driverControlledFreight2: Int
                    public var driverControlledFreight3: Int
                    public var endgameDelivered: Int
                    public var allianceBalanced: Bool
                    public var endgameParked: EndgameParkedStatus
                    public var capped: Int
                    public var minorPenalties: Int
                    public var majorPenalties: Int
                    public var carouselPoints: Int
                    public var autoNavigationPoints: Int
                    public var autoFreightPoints: Int
                    public var autoBonusPoints: Int
                    public var driverControlledAllianceHubPoints: Int
                    public var driverControlledStoragePoints: Int
                    public var endgameDeliveryPoints: Int
                    public var allianceBalancedPoints: Int
                    public var endgameParkingPoints: Int
                    public var cappingPoints: Int
                    public var autoPoints: Int
                    public var driverControlledPoints: Int
                    public var endgamePoints: Int
                    public var penaltyPoints: Int
                    public var totalPoints: Int
                }
            }

            public enum BarcodeElement: String, Codable, Hashable {
                case duck = "DUCK"
                case teamShippingElement = "TEAM_SHIPPING_ELEMENT"
            }

            public enum AutoNavigatedStatus: String, Codable, Hashable {
                case none = "NONE"
                case inStorage = "IN_STORAGE"
                case completelyInStorage = "COMPLETELY_IN_STORAGE"
                case inWarehouse = "IN_WAREHOUSE"
                case completelyInWarehouse = "COMPLETELY_IN_WAREHOUSE"
            }

            public enum EndgameParkedStatus: String, Codable, Hashable {
                case none = "NONE"
                case inWarehouse = "IN_WAREHOUSE"
                case completelyInWarehouse = "COMPLETELY_IN_WAREHOUSE"
            }
        }

        public struct Powerplay {
            public struct Alliance: MatchScoreDetailsItem, Codable, Hashable {
                public var matchLevel: FTCEventLevel
                public var matchSeries: Int
                public var matchNumber: Int
                public var randomization: Int
                public var alliances: [AllianceScores]?

                public struct AllianceScores: SwiFTCDataConformable {
                    public var sideOfField: FieldSide
                    public var initSignalSleeve1: Bool
                    public var initSignalSleeve2: Bool
                    public var robot1Auto: AutoNavigation
                    public var robot2Auto: AutoNavigation
                    public var autoTerminal: Int
                    public var autoJunctions: [[[JunctionElement]]]?
                    public var dcJunctions: [[[JunctionElement]]]?
                    public var dcTerminalNear: Int
                    public var dcTerminalFar: Int
                    public var egNavigated1: Bool
                    public var egNavigated2: Bool
                    public var minorPenalties: Int
                    public var majorPenalties: Int
                    public var autoNavigationPoints: Int
                    public var signalBonusPoints: Int
                    public var autoJunctionConePoints: Int
                    public var autoTerminalConePoints: Int
                    public var dcJunctionConePoints: Int
                    public var dcTerminalConePoints: Int
                    public var ownershipPoints: Int
                    public var circuitPoints: Int
                    public var egNavigationPoints: Int
                    public var autoPoints: Int
                    public var dcPoints: Int
                    public var endgamePoints: Int
                    public var penaltyPointsCommitted: Int
                    public var prePenaltyTotal: Int
                    public var autoJunctionCones: [Int]?
                    public var dcJunctionCones: [Int]?
                    public var beacons: Int
                    public var ownedJunctions: Int
                    public var circuit: Bool
                    public var totalPoints: Int
                    public var alliance: String?
                    public var team: Int
                }
            }

            public struct SingleTeam: MatchScoreDetailsItem, Codable, Hashable {
                public var matchLevel: FTCEventLevel
                public var matchNumber: Int
                public var randomization: Int
                public var teamNumber: Int
                public var scores: Scores

                public struct Scores: SwiFTCDataConformable {
                    public var initSignalSleeve: Bool
                    public var robotAuto: AutoNavigation
                    public var autoTerminal: Int
                    public var autoJunctions: [[[JunctionElement]]]?
                    public var dcJunctions: [[[JunctionElement]]]?
                    public var dcTerminal: Int
                    public var egNavigated: Bool
                    public var minorPenalties: Int
                    public var majorPenalties: Int
                    public var autoNavigationPoints: Int
                    public var signalBonusPoints: Int
                    public var autoJunctionConePoints: Int
                    public var autoTerminalConePoints: Int
                    public var dcJunctionConePoints: Int
                    public var dcTerminalConePoints: Int
                    public var ownershipPoints: Int
                    public var circuitPoints: Int
                    public var egNavigationPoints: Int
                    public var autoPoints: Int
                    public var dcPoints: Int
                    public var endgamePoints: Int
                    public var penaltyPointsCommitted: Int
                    public var prePenaltyTotal: Int
                    public var autoJunctionCones: [Int]?
                    public var dcJunctionCones: [Int]?
                    public var beacons: Int
                    public var ownedJunctions: Int
                    public var circuit: Bool
                    public var totalPoints: Int
                }
            }

            public enum FieldSide: String, Codable, Hashable {
                case scoringSide = "SCORING_SIDE"
                case audienceSide = "AUDIENCE_SIDE"
            }

            public enum AutoNavigation: String, Codable, Hashable {
                case none = "NONE"
                case substationTerminal = "SUBSTATION_TERMINAL"
                case signalZone = "SIGNAL_ZONE"
            }

            public enum JunctionElement: String, Codable, Hashable {
                case myCone = "MY_CONE"
                case otherCone = "OTHER_CONE"
                case myR1Beacon = "MY_R1_BEACON"
                case myR2Beacon = "MY_R2_BEACON"
                case otherR1Beacon = "OTHER_R1_BEACON"
                case otherR2Beacon = "OTHER_R2_BEACON"
            }
        }

        public struct Centerstage {
            public struct Alliance: MatchScoreDetailsItem, Codable, Hashable {
                public var matchLevel: FTCEventLevel
                public var matchSeries: Int
                public var matchNumber: Int
                public var randomization: Int
                public var alliances: [AllianceScores]?

                public struct AllianceScores: SwiFTCDataConformable {
                    public var initTeamProp1: Bool
                    public var initTeamProp2: Bool
                    public var robot1Auto: Bool
                    public var robot2Auto: Bool
                    public var spikeMarkPixel1: Bool
                    public var spikeMarkPixel2: Bool
                    public var targetBackdropPixel1: Bool
                    public var targetBackdropPixel2: Bool
                    public var autoBackdrop: Int
                    public var autoBackstage: Int
                    public var dcBackdrop: Int
                    public var dcBackstage: Int
                    public var mosaics: Int
                    public var maxSetLine: Int
                    public var egRobot1: EndGameLocation
                    public var egRobot2: EndGameLocation
                    public var drone1: Int
                    public var drone2: Int
                    public var minorPenalties: Int
                    public var majorPenalties: Int
                    public var autoNavigatingPoints: Int
                    public var autoRandomizationPoints: Int
                    public var autoBackstagePoints: Int
                    public var autoBackdropPoints: Int
                    public var dcBackdropPoints: Int
                    public var dcBackstagePoints: Int
                    public var mosaicPoints: Int
                    public var setBonusPoints: Int
                    public var egLocationPoints: Int
                    public var egDronePoints: Int
                    public var autoPoints: Int
                    public var dcPoints: Int
                    public var endgamePoints: Int
                    public var penaltyPointsCommitted: Int
                    public var prePenaltyTotal: Int
                    public var totalPoints: Int
                    public var alliance: String?
                    public var team: Int
                }
            }

            public struct SingleTeam: MatchScoreDetailsItem, Codable, Hashable {
                public var matchLevel: FTCEventLevel
                public var matchNumber: Int
                public var randomization: Int
                public var teamNumber: Int
                public var scores: Scores

                public struct Scores: SwiFTCDataConformable {
                    public var initTeamProp: Bool
                    public var robotAuto: Bool
                    public var spikeMarkPixel: Bool
                    public var targetBackdropPixel: Bool
                    public var autoBackdrop: Int
                    public var autoBackstage: Int
                    public var dcBackdrop: Int
                    public var dcBackstage: Int
                    public var mosaics: Int
                    public var maxSetLine: Int
                    public var egRobot: EndGameLocation
                    public var drone: Int
                    public var minorPenalties: Int
                    public var majorPenalties: Int
                    public var autoNavigatingPoints: Int
                    public var autoRandomizationPoints: Int
                    public var autoBackstagePoints: Int
                    public var autoBackdropPoints: Int
                    public var dcBackdropPoints: Int
                    public var dcBackstagePoints: Int
                    public var mosaicPoints: Int
                    public var setBonusPoints: Int
                    public var egLocationPoints: Int
                    public var egDronePoints: Int
                    public var autoPoints: Int
                    public var dcPoints: Int
                    public var endgamePoints: Int
                    public var penaltyPointsCommitted: Int
                    public var prePenaltyTotal: Int
                    public var totalPoints: Int
                }
            }

            public enum EndGameLocation: String, Codable, Hashable {
                case none = "NONE"
                case backstage = "BACKSTAGE"
                case rigging = "RIGGING"
            }
        }

        public struct IntoTheDeep: MatchScoreDetailsItem, Codable, Hashable {
            public var matchLevel: FTCEventLevel
            public var matchSeries: Int
            public var matchNumber: Int
            public var randomization: Int
            public var alliances: [AllianceScores]?

            public struct AllianceScores: SwiFTCDataConformable {
                public var robot1Auto: AutoLocation
                public var robot2Auto: AutoLocation

                public var autoSampleNet: Int
                public var autoSampleLow: Int
                public var autoSampleHigh: Int
                public var autoSpecimenLow: Int
                public var autoSpecimenHigh: Int
                public var teleopSampleNet: Int
                public var teleopSampleLow: Int
                public var teleopSampleHigh: Int
                public var teleopSpecimenLow: Int
                public var teleopSpecimenHigh: Int

                public var robot1Teleop: TeleopLocation
                public var robot2Teleop: TeleopLocation

                public var minorFouls: Int
                public var majorFouls: Int

                public var autoSamplePoints: Int
                public var autoSpecimenPoints: Int
                public var teleopSamplePoints: Int
                public var teleopSpecimenPoints: Int
                public var teleopParkPoints: Int
                public var teleopAscentPoints: Int
                public var autoPoints: Int
                public var teleopPoints: Int
                public var endGamePoints: Int
                public var foulPointsCommitted: Int
                public var preFoulTotal: Int
                public var totalPoints: Int

                public var alliance: String?
                public var team: Int
            }

            public enum AutoLocation: String, Codable, Hashable {
                case none = "NONE"
                case observationZone = "OBSERVATION_ZONE"
                case ascent = "ASCENT"
            }

            public enum TeleopLocation: String, Codable, Hashable {
                case none = "NONE"
                case observationZone = "OBSERVATION_ZONE"
                case ascent1 = "ASCENT_1"
                case ascent2 = "ASCENT_2"
                case ascent3 = "ASCENT_3"
            }
        }
    }

    public struct ScoreDetails<T: MatchScoreDetailsItem>: SwiFTCDataConformable {
        public var matchScores: [T]?
    }

    public struct AllianceSelectionDetails: SwiFTCDataConformable {
        public let selections: [Selection]?
        public let count: Int

        public struct Selection: SwiFTCDataConformable {
            public let index: Int
            public let team: Int
            public let result: SelectionResult
        }

        public enum SelectionResult: String, Codable, Hashable {
            case accept = "ACCEPT"
            case decline = "DECLINE"
            case remove = "REMOVE"
            case captain = "CAPTAIN"
        }
    }

    public struct AwardsListing: SwiFTCDataConformable {
        public let awards: [Award]?

        public struct Award: SwiFTCDataConformable {
            public let awardId: Int
            public let name: String?
            public let description: String?
            public let forPerson: Bool
        }
    }

    public struct ReceivedAwards: SwiFTCDataConformable {
        public let awards: [AwardAssignment]?

        public struct AwardAssignment: SwiFTCDataConformable {
            public let awardId: Int
            public let teamId: Int?
            public let teamProfileId: Int?
            public let eventId: Int?
            public let eventDivisionId: Int?
            public let eventCode: String?
            public let name: String?
            public let series: Int
            public let teamNumber: Int?
            public let schoolName: String?
            public let fullTeamName: String?
            public let person: String?
        }
    }

    public struct EventAdvancement: SwiFTCDataConformable {
        public let advancesTo: String?
        public let slots: Int
        public let advancement: [AdvancementOrder]?
    }

    public typealias AdvancementSource = [AdvancementSourceItem]

    public struct AdvancementSourceItem: SwiFTCDataConformable {
        public let advancedFrom: String?
        public let advancedFromRegion: String?
        public let slots: Int
        public let advancement: [AdvancementOrder]?
    }

    public struct TeamRanking: SwiFTCDataConformable {
        public let rank: Int
        public let teamNumber: Int
        public let displayTeamNumber: String?
        public let teamName: String?
        public let sortOrder1: Double
        public let sortOrder2: Double
        public let sortOrder3: Double
        public let sortOrder4: Double
        public let sortOrder5: Double
        public let sortOrder6: Double
        public let wins: Int
        public let losses: Int
        public let ties: Int
        public let qualAverage: Double
        public let dq: Int
        public let matchesPlayed: Int
        public let matchesCounted: Int
    }

    public enum TournamentLevel: String, Codable, Hashable, RawRepresentable {
        case qualification = "QUALIFICATION"
        case playoff = "PLAYOFF"

        public var parameterValue: String {
            switch self {
            case .qualification:
                "qual"
            case .playoff:
                "playoff"
            }
        }
    }

    public struct AdvancementOrder: SwiFTCDataConformable {
        public let team: Int?
        public let teamId: Int?
        public let teamProfileId: Int?
        public let teamInternalId: UUID?
        public let displayTeam: String?
        public let slot: Int
        public let criteria: String?
        public let declined: Bool
        public let status: APIAdvancementStatus

        public enum APIAdvancementStatus: String, Codable, Hashable {
            case null = "NULL"
            case first = "FIRST"
            case alreadyAdvancing = "ALREADY_ADVANCING"
            case advancingAbove = "ADVANCING_ABOVE"
            case ineligible = "INELIGIBLE"
        }
    }
}

public protocol MatchScoreDetailsItem: SwiFTCDataConformable {
    var matchLevel: FTCEventLevel { get }
    var matchNumber: Int { get }
}

public enum FTCEventLevel: String, Codable, Hashable {
    case practice = "PRACTICE"
    case qualification = "QUALIFICATION"
    case semifinal = "SEMIFINAL"
    case final = "FINAL"
    case playoff = "PLAYOFF"
    case other = "OTHER"
}
