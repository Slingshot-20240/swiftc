//
//  LibDecodeTests.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation
import SwiFTCTestErrors
import Testing

@testable import SwiFTC

struct TestData: Codable, Sendable {

}

let url = Bundle.module.url(
    forResource: "LibDecodeTestData",
    withExtension: "json"
)!
let fileData = try! Data(contentsOf: url)
let testData = try! JSONDecoder().decode(TestData.self, from: fileData)

@Test func calculateTest0() async throws {
    var game = DecodeGameScores()

    game.blue.auto.gameElementZone0 = 0
    game.blue.auto.gameElementZone1 = 0
    game.blue.teleop.team1Location = .none
    game.blue.teleop.team2Location = .none
    game.blue.minorFoulsFromOtherAllianceAwarded = 0
    game.blue.majorFoulsFromOtherAllianceAwarded = 0

    guard game.blue.auto.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue auto",
            game.blue.auto.total,
            0
        )
    }

    guard game.blue.teleop.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue teleop",
            game.blue.teleop.total,
            0
        )
    }

    guard game.blue.foulPointsFromOtherAllianceAwarded == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue fouls",
            game.blue.foulPointsFromOtherAllianceAwarded,
            0
        )
    }

    guard game.blue.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue total",
            game.blue.total,
            0
        )
    }

    print("================================================================")
    print("alliance\tauto\tteleop\tfouls\ttotal")
    print(
        "blue    \t\(game.blue.auto.total)   \t\(game.blue.teleop.total)   \t\(game.blue.foulPointsFromOtherAllianceAwarded)   \t\(game.blue.total)"
    )

    game.red.auto.gameElementZone0 = 0
    game.red.auto.gameElementZone1 = 0
    game.red.teleop.team1Location = .none
    game.red.teleop.team2Location = .none
    game.red.minorFoulsFromOtherAllianceAwarded = 0
    game.red.majorFoulsFromOtherAllianceAwarded = 0

    guard game.red.auto.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red auto",
            game.red.auto.total,
            0
        )
    }

    guard game.red.teleop.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red teleop",
            game.red.teleop.total,
            0
        )
    }

    guard game.red.foulPointsFromOtherAllianceAwarded == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red fouls",
            game.red.foulPointsFromOtherAllianceAwarded,
            0
        )
    }

    guard game.red.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red total",
            game.red.total,
            0
        )
    }

    print(
        "red     \t\(game.red.auto.total)   \t\(game.red.teleop.total)   \t\(game.red.foulPointsFromOtherAllianceAwarded)   \t\(game.red.total)"
    )
}

@Test func calculateTest1() async throws {
    var game = DecodeGameScores()

    game.blue.auto.gameElementZone0 = 0
    game.blue.auto.gameElementZone1 = 0
    game.blue.teleop.team1Location = .none
    game.blue.teleop.team2Location = .none
    game.blue.minorFoulsFromOtherAllianceAwarded = 0
    game.blue.majorFoulsFromOtherAllianceAwarded = 0

    guard game.blue.auto.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue auto",
            game.blue.auto.total,
            0
        )
    }

    guard game.blue.teleop.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue teleop",
            game.blue.teleop.total,
            0
        )
    }

    guard game.blue.foulPointsFromOtherAllianceAwarded == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue fouls",
            game.blue.foulPointsFromOtherAllianceAwarded,
            0
        )
    }

    guard game.blue.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "blue total",
            game.blue.total,
            0
        )
    }

    print("================================================================")
    print("alliance\tauto\tteleop\tfouls\ttotal")
    print(
        "blue    \t\(game.blue.auto.total)   \t\(game.blue.teleop.total)   \t\(game.blue.foulPointsFromOtherAllianceAwarded)   \t\(game.blue.total)"
    )

    game.red.auto.gameElementZone0 = 0
    game.red.auto.gameElementZone1 = 0
    game.red.teleop.team1Location = .none
    game.red.teleop.team2Location = .none
    game.red.minorFoulsFromOtherAllianceAwarded = 0
    game.red.majorFoulsFromOtherAllianceAwarded = 0

    guard game.red.auto.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red auto",
            game.red.auto.total,
            0
        )
    }

    guard game.red.teleop.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red teleop",
            game.red.teleop.total,
            0
        )
    }

    guard game.red.foulPointsFromOtherAllianceAwarded == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red fouls",
            game.red.foulPointsFromOtherAllianceAwarded,
            0
        )
    }

    guard game.red.total == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red total",
            game.red.total,
            0
        )
    }

    print(
        "red     \t\(game.red.auto.total)   \t\(game.red.teleop.total)   \t\(game.red.foulPointsFromOtherAllianceAwarded)   \t\(game.red.total)"
    )
}
