//
//  FTCAPIData.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct FTCAPIData {
    static var decoder: JSONDecoder {
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

    static func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T
    {
        return try Self.decoder.decode(type, from: data)
    }

    struct APIIndex: Codable {
        let name: String?
        let apiName: String?
        let apiVersion: String?
        let serviceMainifestName: String?
        let serviceMainifestVersion: String?
        let codePackageName: String?
        let codePackageVersion: String?
        let status: String?
        let currentSeason: Int
        let maxSeason: Int
    }

    struct SeasonSummary: Codable {
        let eventCount: Int
        let gameName: String?
        let kickoff: Date?
        let rookieStart: Int
        let teamCount: Int
        let frcChampionships: [ChampionshipDescription]?

        struct ChampionshipDescription: Codable {
            let name: String?
            let startDate: Date?
            let location: String?
        }
    }

    struct LeagueListings: Codable {
        let leagues: [League]?
        let leagueCount: Int

        struct League: Codable {
            let region: String?
            let code: String?
            let name: String?
            let remote: Bool?
            let parentLeagueCode: String?
            let parentLeagueName: String?
            let location: String?
        }
    }

    struct LeagueMembership: Codable {
        let members: [Int]?
    }

    struct LeagueRankings: Codable {
        let rankings: [TeamRanking]?
    }

    struct TeamListings: Codable {
        let teams: [Team]?
        let teamCountTotal: Int
        let teamCountPage: Int
        let pageCurrent: Int
        let pageTotal: Int

        struct Team: Codable {
            let teamNumber: Int
            let displayTeamNumber: String?
            let nameFull: String?
            let nameShort: String?
            let schoolName: String?
            let city: String?
            let stateProv: String?
            let country: String?
            let website: String?
            let rookieYear: Int?
            let robotName: String?
            let districtCode: String?
            let homeCMP: String?
            let homeRegion: String?
            let displayLocation: String?
        }
    }

    struct EventListings: Codable {
        let events: [EventListings.Event]?
        let eventCount: Int

        struct Event: Codable {
            let eventId: String
            let code: String?
            let divisionCode: String?
            let name: String?
            let remote: Bool
            let hybrid: Bool
            let fieldCount: Int
            let published: Bool
            let type: String?
            let typeName: String?
            let regionCode: String?
            let leagueCode: String?
            let districtCode: String?
            let venue: String?
            let address: String?
            let city: String?
            let stateprov: String?
            let country: String?
            let website: String?
            let liveStreamUrl: String?
            let coordinates: Coordinates?
            let webcasts: [String]?
            let timezone: String?
            let dateStart: Date
            let dateEnd: Date

            struct Coordinates: Codable {
                let type: String
                let coordinates: [Double]
            }
        }
    }

    struct HybridSchedule: Codable {
        let schedule: [Match]?

        struct Match: Codable {
            let description: String?
            let tournamentLevel: TournamentLevel?
            let series: Int
            let matchNumber: Int
            let startTime: Date?
            let actualStartTime: Date?
            let postResultTime: Date?
            let scoreRedFinal: Int?
            let scoreRedFoul: Int?
            let scoreRedAuto: Int?
            let scoreBlueFinal: Int?
            let scoreBlueFoul: Int?
            let scoreBlueAuto: Int?
            let scoreBlueDriveControlled: Int?
            let scoreBlueEndgame: Int?
            let redWins: Bool?
            let blueWins: Bool?
            let teams: [Team]?

            struct Team: Codable {
                let teamNumber: Int?
                let displayTeamNumber: String?
                let station: String?
                let surrogate: Bool
                let noShow: Bool
                let dq: Bool?
                let onField: Bool?
                let teamName: String?
            }
        }
    }

    struct EventSchedule: Codable {
        let schedule: [ScheduledMatch]?

        struct ScheduledMatch: Codable {
            let description: String?
            let field: String?
            let tournamentLevel: TournamentLevel?
            let startTime: Date?
            let series: Int
            let matchNumber: Int
            let teams: [Team]?
            let modifiedOn: Date?

            struct Team: Codable {
                let teamNumber: Int?
                let displayTeamNumber: String?
                let station: String?
                let team: String?
                let teamName: String?
                let surrogate: Bool
                let noShow: Bool
            }
        }
    }

    struct EventRankings: Codable {
        let rankings: [TeamRanking]?
    }

    struct EventAlliances: Codable {
        let alliances: [Alliance]?
        let count: Int

        struct Alliance: Codable {
            let number: Int
            let name: String?
            let captain: Int?
            let captainDisplay: String?
            let round1: Int?
            let round1Display: String?
            let round2: Int?
            let round2Display: String?
            let round3: Int?
            let backup: Int?
            let backupReplaced: Int?
        }
    }

    struct EventMatchResults: Codable {
        let matches: [MatchResult]?

        struct MatchResult: Codable {
            let actualStartTime: String?
            let description: String?
            let tournamentLevel: TournamentLevel?
            let series: Int
            let matchNumber: Int
            let scoreRedFinal: Int
            let scoreRedFoul: Int
            let scoreRedAuto: Int
            let scoreBlueFinal: Int
            let scoreBlueFoul: Int
            let scoreBlueAuto: Int
            let postResultTime: String?
            let teams: [Team]?
            let modifiedOn: String?

            struct Team: Codable {
                let teamNumber: Int
                let station: String?
                let dq: Bool
                let onField: Bool
            }
        }
    }

    enum AnyScoreDetails {
        static func decode(
            for season: FTCSeason,
            from data: Data
        ) throws -> AnyScoreDetails {
            let decoder = FTCAPIData.decoder

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

        struct Skystone: MatchScoreDetailsItem, Codable {
            let matchLevel: FTCEventLevel
            let matchSeries: Int
            let matchNumber: Int
            let alliances: [AllianceScores]?

            struct AllianceScores: Codable {
                let alliance: String?
                let robot1Navigated: Bool
                let robot1Parked: Bool
                let robot1CapstoneLevel: Int
                let robot2Navigated: Bool
                let robot2Parked: Bool
                let robot2CapstoneLevel: Int
                let autoStones: [Stone]?
                let autoDelivered: Int
                let autoReturned: Int
                let firstReturnedIsSkystone: Bool
                let autoPlaced: Int
                let foundationRepositioned: Bool
                let foundationMoved: Bool
                let driverControlledDelivered: Int
                let driverControlledReturned: Int
                let driverControlledPlaced: Int
                let tallestSkyscraper: Int
                let autoDeliveryPoints: Int
                let autoPlacedPoints: Int
                let autonomousPoints: Int
                let repositionedPoints: Int
                let navigationPoints: Int
                let driverControlledDeliveryPoints: Int
                let driverControlledPlacedPoints: Int
                let skyscraperBonusPoints: Int
                let capstonePoints: Int
                let driverControlledPoints: Int
                let parkingPoints: Int
                let endGamePoints: Int
                let minorPenalties: Int
                let majorPenalties: Int
                let penaltyPoints: Int
                let totalPoints: Int
            }

            enum Stone: String, Codable {
                case none = "NONE"
                case stone = "STONE"
                case skystone = "SKYSTONE"
            }
        }

        struct UltimateGoal {
            struct Alliance: MatchScoreDetailsItem, Codable {
                let matchLevel: FTCEventLevel
                let matchSeries: Int
                let matchNumber: Int
                let alliances: [AllianceScores]?

                struct AllianceScores: Codable {
                    let adjust: Int
                    let dcPoints: Int
                    let autoPoints: Int
                    let dcTowerLow: Int
                    let dcTowerMid: Int
                    let dcTowerHigh: Int
                    let navigated1: Bool
                    let navigated2: Bool
                    let wobbleDelivered1: Bool
                    let wobbleDelivered2: Bool
                    let autoTowerLow: Int
                    let autoTowerMid: Int
                    let autoTowerHigh: Int
                    let autoTowerPoints: Int
                    let autoPowerShotLeft: Bool
                    let autoPowerShotCenter: Bool
                    let autoPowerShotRight: Bool
                    let autoPowerShotPoints: Int
                    let wobbleRings1: Int
                    let wobbleRings2: Int
                    let wobbleEnd1: Int
                    let wobbleEnd2: Int
                    let wobbleEndPoints: Int
                    let wobbleRingPoints: Int
                    let autoWobblePoints: Int
                    let endPowerShotLeft: Bool
                    let endPowerShotCenter: Bool
                    let endPowerShotRight: Bool
                    let endPowerShotPoints: Int
                    let penaltyPoints: Int
                    let majorPenalties: Int
                    let minorPenalties: Int
                    let navigationPoints: Int
                    let endgamePoints: Int
                    let totalPoints: Int
                    let alliance: String?
                    let team: Int
                }
            }

            struct SingleTeam: MatchScoreDetailsItem, Codable {
                let matchLevel: FTCEventLevel
                let matchNumber: Int
                let teamNumber: Int
                let scores: Scores

                struct Scores: Codable {
                    let adjust: Int
                    let dcPoints: Int
                    let autoPoints: Int
                    let dcTowerLow: Int
                    let dcTowerMid: Int
                    let dcTowerHigh: Int
                    let navigated1: Bool
                    let navigated2: Bool
                    let wobbleDelivered1: Bool
                    let wobbleDelivered2: Bool
                    let autoTowerLow: Int
                    let autoTowerMid: Int
                    let autoTowerHigh: Int
                    let autoTowerPoints: Int
                    let autoPowerShotLeft: Bool
                    let autoPowerShotCenter: Bool
                    let autoPowerShotRight: Bool
                    let autoPowerShotPoints: Int
                    let wobbleRings1: Int
                    let wobbleRings2: Int
                    let wobbleEnd1: Int
                    let wobbleEnd2: Int
                    let wobbleEndPoints: Int
                    let wobbleRingPoints: Int
                    let autoWobblePoints: Int
                    let endPowerShotLeft: Bool
                    let endPowerShotCenter: Bool
                    let endPowerShotRight: Bool
                    let endPowerShotPoints: Int
                    let penaltyPoints: Int
                    let majorPenalties: Int
                    let minorPenalties: Int
                    let navigationPoints: Int
                    let endgamePoints: Int
                    let totalPoints: Int
                }
            }
        }

        struct FreightFrenzy {
            struct Alliance: MatchScoreDetailsItem, Codable {
                let matchLevel: FTCEventLevel
                let matchSeries: Int
                let matchNumber: Int
                let randomization: Int
                let alliances: [AllianceScores]?

                struct AllianceScores: Codable {
                    let alliance: String?
                    let barcodeElement1: BarcodeElement
                    let barcodeElement2: BarcodeElement
                    let carousel: Bool
                    let autoNavigated1: AutoNavigatedStatus
                    let autoNavigated2: AutoNavigatedStatus
                    let autoBonus1: Bool
                    let autoBonus2: Bool
                    let autoStorageFreight: Int
                    let autoFreight1: Int
                    let autoFreight2: Int
                    let autoFreight3: Int
                    let driverControlledStorageFreight: Int
                    let driverControlledFreight1: Int
                    let driverControlledFreight2: Int
                    let driverControlledFreight3: Int
                    let sharedFreight: Int
                    let endgameDelivered: Int
                    let allianceBalanced: Bool
                    let sharedUnbalanced: Bool
                    let endgameParked1: EndgameParkedStatus
                    let endgameParked2: EndgameParkedStatus
                    let capped: Int
                    let minorPenalties: Int
                    let majorPenalties: Int
                    let carouselPoints: Int
                    let autoNavigationPoints: Int
                    let autoFreightPoints: Int
                    let autoBonusPoints: Int
                    let driverControlledAllianceHubPoints: Int
                    let driverControlledSharedHubPoints: Int
                    let driverControlledStoragePoints: Int
                    let endgameDeliveryPoints: Int
                    let allianceBalancedPoints: Int
                    let sharedUnbalancedPoints: Int
                    let endgameParkingPoints: Int
                    let cappingPoints: Int
                    let autoPoints: Int
                    let driverControlledPoints: Int
                    let endgamePoints: Int
                    let penaltyPoints: Int
                    let totalPoints: Int
                }
            }

            struct SingleTeam: MatchScoreDetailsItem, Codable {
                var matchLevel: FTCEventLevel
                var matchNumber: Int
                var randomization: Int
                var teamNumber: Int
                var scores: Scores

                struct Scores: Codable {
                    var barcodeElement: BarcodeElement
                    var carousel: Bool
                    var autoNavigated: AutoNavigatedStatus
                    var autoBonus: Bool
                    var autoStorageFreight: Int
                    var autoFreight1: Int
                    var autoFreight2: Int
                    var autoFreight3: Int
                    var driverControlledStorageFreight: Int
                    var driverControlledFreight1: Int
                    var driverControlledFreight2: Int
                    var driverControlledFreight3: Int
                    var endgameDelivered: Int
                    var allianceBalanced: Bool
                    var endgameParked: EndgameParkedStatus
                    var capped: Int
                    var minorPenalties: Int
                    var majorPenalties: Int
                    var carouselPoints: Int
                    var autoNavigationPoints: Int
                    var autoFreightPoints: Int
                    var autoBonusPoints: Int
                    var driverControlledAllianceHubPoints: Int
                    var driverControlledStoragePoints: Int
                    var endgameDeliveryPoints: Int
                    var allianceBalancedPoints: Int
                    var endgameParkingPoints: Int
                    var cappingPoints: Int
                    var autoPoints: Int
                    var driverControlledPoints: Int
                    var endgamePoints: Int
                    var penaltyPoints: Int
                    var totalPoints: Int
                }
            }

            enum BarcodeElement: String, Codable {
                case duck = "DUCK"
                case teamShippingElement = "TEAM_SHIPPING_ELEMENT"
            }

            enum AutoNavigatedStatus: String, Codable {
                case none = "NONE"
                case inStorage = "IN_STORAGE"
                case completelyInStorage = "COMPLETELY_IN_STORAGE"
                case inWarehouse = "IN_WAREHOUSE"
                case completelyInWarehouse = "COMPLETELY_IN_WAREHOUSE"
            }

            enum EndgameParkedStatus: String, Codable {
                case none = "NONE"
                case inWarehouse = "IN_WAREHOUSE"
                case completelyInWarehouse = "COMPLETELY_IN_WAREHOUSE"
            }
        }

        struct Powerplay {
            struct Alliance: MatchScoreDetailsItem, Codable {
                var matchLevel: FTCEventLevel
                var matchSeries: Int
                var matchNumber: Int
                var randomization: Int
                var alliances: [AllianceScores]?

                struct AllianceScores: Codable {
                    var sideOfField: FieldSide
                    var initSignalSleeve1: Bool
                    var initSignalSleeve2: Bool
                    var robot1Auto: AutoNavigation
                    var robot2Auto: AutoNavigation
                    var autoTerminal: Int
                    var autoJunctions: [[[JunctionElement]]]?
                    var dcJunctions: [[[JunctionElement]]]?
                    var dcTerminalNear: Int
                    var dcTerminalFar: Int
                    var egNavigated1: Bool
                    var egNavigated2: Bool
                    var minorPenalties: Int
                    var majorPenalties: Int
                    var autoNavigationPoints: Int
                    var signalBonusPoints: Int
                    var autoJunctionConePoints: Int
                    var autoTerminalConePoints: Int
                    var dcJunctionConePoints: Int
                    var dcTerminalConePoints: Int
                    var ownershipPoints: Int
                    var circuitPoints: Int
                    var egNavigationPoints: Int
                    var autoPoints: Int
                    var dcPoints: Int
                    var endgamePoints: Int
                    var penaltyPointsCommitted: Int
                    var prePenaltyTotal: Int
                    var autoJunctionCones: [Int]?
                    var dcJunctionCones: [Int]?
                    var beacons: Int
                    var ownedJunctions: Int
                    var circuit: Bool
                    var totalPoints: Int
                    var alliance: String?
                    var team: Int
                }
            }

            struct SingleTeam: MatchScoreDetailsItem, Codable {
                var matchLevel: FTCEventLevel
                var matchNumber: Int
                var randomization: Int
                var teamNumber: Int
                var scores: Scores

                struct Scores: Codable {
                    var initSignalSleeve: Bool
                    var robotAuto: AutoNavigation
                    var autoTerminal: Int
                    var autoJunctions: [[[JunctionElement]]]?
                    var dcJunctions: [[[JunctionElement]]]?
                    var dcTerminal: Int
                    var egNavigated: Bool
                    var minorPenalties: Int
                    var majorPenalties: Int
                    var autoNavigationPoints: Int
                    var signalBonusPoints: Int
                    var autoJunctionConePoints: Int
                    var autoTerminalConePoints: Int
                    var dcJunctionConePoints: Int
                    var dcTerminalConePoints: Int
                    var ownershipPoints: Int
                    var circuitPoints: Int
                    var egNavigationPoints: Int
                    var autoPoints: Int
                    var dcPoints: Int
                    var endgamePoints: Int
                    var penaltyPointsCommitted: Int
                    var prePenaltyTotal: Int
                    var autoJunctionCones: [Int]?
                    var dcJunctionCones: [Int]?
                    var beacons: Int
                    var ownedJunctions: Int
                    var circuit: Bool
                    var totalPoints: Int
                }
            }

            enum FieldSide: String, Codable {
                case scoringSide = "SCORING_SIDE"
                case audienceSide = "AUDIENCE_SIDE"
            }

            enum AutoNavigation: String, Codable {
                case none = "NONE"
                case substationTerminal = "SUBSTATION_TERMINAL"
                case signalZone = "SIGNAL_ZONE"
            }

            enum JunctionElement: String, Codable {
                case myCone = "MY_CONE"
                case otherCone = "OTHER_CONE"
                case myR1Beacon = "MY_R1_BEACON"
                case myR2Beacon = "MY_R2_BEACON"
                case otherR1Beacon = "OTHER_R1_BEACON"
                case otherR2Beacon = "OTHER_R2_BEACON"
            }
        }

        struct Centerstage {
            struct Alliance: MatchScoreDetailsItem, Codable {
                var matchLevel: FTCEventLevel
                var matchSeries: Int
                var matchNumber: Int
                var randomization: Int
                var alliances: [AllianceScores]?

                struct AllianceScores: Codable {
                    var initTeamProp1: Bool
                    var initTeamProp2: Bool
                    var robot1Auto: Bool
                    var robot2Auto: Bool
                    var spikeMarkPixel1: Bool
                    var spikeMarkPixel2: Bool
                    var targetBackdropPixel1: Bool
                    var targetBackdropPixel2: Bool
                    var autoBackdrop: Int
                    var autoBackstage: Int
                    var dcBackdrop: Int
                    var dcBackstage: Int
                    var mosaics: Int
                    var maxSetLine: Int
                    var egRobot1: EndGameLocation
                    var egRobot2: EndGameLocation
                    var drone1: Int
                    var drone2: Int
                    var minorPenalties: Int
                    var majorPenalties: Int
                    var autoNavigatingPoints: Int
                    var autoRandomizationPoints: Int
                    var autoBackstagePoints: Int
                    var autoBackdropPoints: Int
                    var dcBackdropPoints: Int
                    var dcBackstagePoints: Int
                    var mosaicPoints: Int
                    var setBonusPoints: Int
                    var egLocationPoints: Int
                    var egDronePoints: Int
                    var autoPoints: Int
                    var dcPoints: Int
                    var endgamePoints: Int
                    var penaltyPointsCommitted: Int
                    var prePenaltyTotal: Int
                    var totalPoints: Int
                    var alliance: String?
                    var team: Int
                }
            }

            struct SingleTeam: MatchScoreDetailsItem, Codable {
                var matchLevel: FTCEventLevel
                var matchNumber: Int
                var randomization: Int
                var teamNumber: Int
                var scores: Scores

                struct Scores: Codable {
                    var initTeamProp: Bool
                    var robotAuto: Bool
                    var spikeMarkPixel: Bool
                    var targetBackdropPixel: Bool
                    var autoBackdrop: Int
                    var autoBackstage: Int
                    var dcBackdrop: Int
                    var dcBackstage: Int
                    var mosaics: Int
                    var maxSetLine: Int
                    var egRobot: EndGameLocation
                    var drone: Int
                    var minorPenalties: Int
                    var majorPenalties: Int
                    var autoNavigatingPoints: Int
                    var autoRandomizationPoints: Int
                    var autoBackstagePoints: Int
                    var autoBackdropPoints: Int
                    var dcBackdropPoints: Int
                    var dcBackstagePoints: Int
                    var mosaicPoints: Int
                    var setBonusPoints: Int
                    var egLocationPoints: Int
                    var egDronePoints: Int
                    var autoPoints: Int
                    var dcPoints: Int
                    var endgamePoints: Int
                    var penaltyPointsCommitted: Int
                    var prePenaltyTotal: Int
                    var totalPoints: Int
                }
            }

            enum EndGameLocation: String, Codable {
                case none = "NONE"
                case backstage = "BACKSTAGE"
                case rigging = "RIGGING"
            }
        }

        struct IntoTheDeep: MatchScoreDetailsItem, Codable {
            var matchLevel: FTCEventLevel
            var matchSeries: Int
            var matchNumber: Int
            var randomization: Int
            var alliances: [AllianceScores]?

            struct AllianceScores: Codable {
                var robot1Auto: AutoLocation
                var robot2Auto: AutoLocation

                var autoSampleNet: Int
                var autoSampleLow: Int
                var autoSampleHigh: Int
                var autoSpecimenLow: Int
                var autoSpecimenHigh: Int
                var teleopSampleNet: Int
                var teleopSampleLow: Int
                var teleopSampleHigh: Int
                var teleopSpecimenLow: Int
                var teleopSpecimenHigh: Int

                var robot1Teleop: TeleopLocation
                var robot2Teleop: TeleopLocation

                var minorFouls: Int
                var majorFouls: Int

                var autoSamplePoints: Int
                var autoSpecimenPoints: Int
                var teleopSamplePoints: Int
                var teleopSpecimenPoints: Int
                var teleopParkPoints: Int
                var teleopAscentPoints: Int
                var autoPoints: Int
                var teleopPoints: Int
                var endGamePoints: Int
                var foulPointsCommitted: Int
                var preFoulTotal: Int
                var totalPoints: Int

                var alliance: String?
                var team: Int
            }

            enum AutoLocation: String, Codable {
                case none = "NONE"
                case observationZone = "OBSERVATION_ZONE"
                case ascent = "ASCENT"
            }

            enum TeleopLocation: String, Codable {
                case none = "NONE"
                case observationZone = "OBSERVATION_ZONE"
                case ascent1 = "ASCENT_1"
                case ascent2 = "ASCENT_2"
                case ascent3 = "ASCENT_3"
            }
        }
    }

    struct ScoreDetails<T: MatchScoreDetailsItem>: Codable {
        var matchScores: [T]?
    }

    struct AllianceSelectionDetails: Codable {
        let selections: [Selection]?
        let count: Int

        struct Selection: Codable {
            let index: Int
            let team: Int
            let result: SelectionResult
        }

        enum SelectionResult: String, Codable {
            case accept = "ACCEPT"
            case decline = "DECLINE"
            case remove = "REMOVE"
            case captain = "CAPTAIN"
        }
    }

    struct AwardsListing: Codable {
        let awards: [Award]?

        struct Award: Codable {
            let awardId: Int
            let name: String?
            let description: String?
            let forPerson: Bool
        }
    }

    struct ReceivedAwards: Codable {
        let awards: [AwardAssignment]?

        struct AwardAssignment: Codable {
            let awardId: Int
            let teamId: Int?
            let teamProfileId: Int?
            let eventId: Int?
            let eventDivisionId: Int?
            let eventCode: String?
            let name: String?
            let series: Int
            let teamNumber: Int?
            let schoolName: String?
            let fullTeamName: String?
            let person: String?
        }
    }

    struct EventAdvancement: Codable {
        let advancesTo: String?
        let slots: Int
        let advancement: [AdvancementOrder]?
    }

    typealias AdvancementSource = [AdvancementSourceItem]

    struct AdvancementSourceItem: Codable {
        let advancedFrom: String?
        let advancedFromRegion: String?
        let slots: Int
        let advancement: [AdvancementOrder]?
    }

    struct TeamRanking: Codable {
        let rank: Int
        let teamNumber: Int
        let displayTeamNumber: String?
        let teamName: String?
        let sortOrder1: Double
        let sortOrder2: Double
        let sortOrder3: Double
        let sortOrder4: Double
        let sortOrder5: Double
        let sortOrder6: Double
        let wins: Int
        let losses: Int
        let ties: Int
        let qualAverage: Double
        let dq: Int
        let matchesPlayed: Int
        let matchesCounted: Int
    }

    enum TournamentLevel: String, Codable, RawRepresentable {
        case qualification = "QUALIFICATION"
        case playoff = "PLAYOFF"

        var parameterValue: String {
            switch self {
            case .qualification:
                "qual"
            case .playoff:
                "playoff"
            }
        }
    }

    struct AdvancementOrder: Codable {
        let team: Int?
        let teamId: Int?
        let teamProfileId: Int?
        let teamInternalId: UUID?
        let displayTeam: String?
        let slot: Int
        let criteria: String?
        let declined: Bool
        let status: APIAdvancementStatus

        enum APIAdvancementStatus: String, Codable {
            case null = "NULL"
            case first = "FIRST"
            case alreadyAdvancing = "ALREADY_ADVANCING"
            case advancingAbove = "ADVANCING_ABOVE"
            case ineligible = "INELIGIBLE"
        }
    }
}

public protocol MatchScoreDetailsItem: Codable {
    var matchLevel: FTCEventLevel { get }
    var matchNumber: Int { get }
}

public enum FTCEventLevel: String, Codable {
    case practice = "PRACTICE"
    case qualification = "QUALIFICATION"
    case semifinal = "SEMIFINAL"
    case final = "FINAL"
    case playoff = "PLAYOFF"
    case other = "OTHER"
}
