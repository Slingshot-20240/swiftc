import Foundation
import Testing

@testable import SwiFTC

struct FTCAPITestConfig: Codable, Sendable {
    let season: FTCSeason
    let username: String
    let token: String
}

let url = Bundle.module.url(
    forResource: "FTCAPITestConfig",
    withExtension: "json"
)!
let data = try! Data(contentsOf: url)
let config = try! JSONDecoder().decode(FTCAPITestConfig.self, from: data)

@Test func eventAdvancementTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.eventAdvancements(at: "USTXTBSQ"))
}

@Test func advancementSourceTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.advancementSource(at: "USTXTBSQ"))
}

@Test func leagueListingsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.leagueListings())
}

@Test func leagueMembershipTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.leagueMembership(regionCode: "USTX", leagueCode: "CG"))
}

@Test func leagueRankingsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.leagueRankings(regionCode: "USTX", leagueCode: "CG"))
}

@Test func apiIndexTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.apiIndex())
}

@Test func seasonSummaryTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.seasonSummary())
}

@Test func eventListingsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.eventListings())
}

@Test func teamListingsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.teamListings())
}

@Test func hybridScheduleTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(
        try await ftc.hybridSchedule(
            at: "USTXAUQ",
            tournamentLevel: .qualification
        )
    )
}

@Test func eventScheduleTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(
        try await ftc.eventSchedule(
            at: "USTXAUQ",
            tournamentLevel: .qualification
        )
    )
}

@Test func eventRankingsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.eventRankings(at: "USTXAUQ"))
}

@Test func eventAlliancesTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.eventAlliances(at: "USTXAUQ"))
}

@Test func allianceSelectionDetailsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.allianceSelectionDetails(at: "USTXAUQ"))
}

@Test func eventMatchResultsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.eventMatchResults(at: "USTXAUQ"))
}

@Test func scoreDetailsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(
        try await ftc.scoreDetails(
            at: "USTXAUQ",
            tournamentLevel: .qualification
        )
    )
}

@Test func awardListingsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.awardListings())
}

@Test func teamAwardsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.teamAwards(for: "20240"))
}

@Test func teamEventAwardsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.teamEventAwards(at: "USTXCGLT", for: "20240"))
}

@Test func eventAwardsTest() async throws {
    let ftc = try await FTCAPI(
        config.season,
        username: config.username,
        token: config.token
    )

    print(try await ftc.eventAwards(at: "FTCCMP1"))
}
