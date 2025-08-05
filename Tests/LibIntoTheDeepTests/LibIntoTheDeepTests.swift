//
//  LibIntoTheDeepTests.swift
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
    forResource: "LibIntoTheDeepTestData",
    withExtension: "json"
)!
let fileData = try! Data(contentsOf: url)
let testData = try! JSONDecoder().decode(TestData.self, from: fileData)

@Test func calculateTest0() async throws {
    var game = IntoTheDeepGameScores()

    game.blue.auto.samplesNet = 1
    game.blue.auto.samplesLow = 3
    game.blue.auto.samplesHigh = 2
    game.blue.auto.specimenLow = 4
    game.blue.auto.specimenHigh = 5
    game.blue.auto.team1Location = .oZone
    game.blue.auto.team2Location = .aZone
    game.blue.teleop.samplesNet = 5
    game.blue.teleop.samplesLow = 4
    game.blue.teleop.samplesHigh = 12
    game.blue.teleop.specimenLow = 7
    game.blue.teleop.specimenHigh = 5
    game.blue.teleop.team1Location = .aZone
    game.blue.teleop.team2Location = .l3
    game.blue.minorFoulsFromOtherAllianceAwarded = 2
    game.blue.majorFoulsFromOtherAllianceAwarded = 1

    guard game.blue.auto.total == 110 else {
        throw CalculationTestErrors.wrongScore(
            "blue auto",
            game.blue.auto.total,
            110
        )
    }

    guard game.blue.teleop.total == 247 else {
        throw CalculationTestErrors.wrongScore(
            "blue teleop",
            game.blue.teleop.total,
            247
        )
    }

    guard game.blue.foulPointsFromOtherAllianceAwarded == 25 else {
        throw CalculationTestErrors.wrongScore(
            "blue fouls",
            game.blue.foulPointsFromOtherAllianceAwarded,
            25
        )
    }

    guard game.blue.total == 382 else {
        throw CalculationTestErrors.wrongScore(
            "blue total",
            game.blue.total,
            382
        )
    }

    print("================================================================")
    print("alliance\tauto\tteleop\tfouls\ttotal")
    print(
        "blue    \t\(game.blue.auto.total)   \t\(game.blue.teleop.total)   \t\(game.blue.foulPointsFromOtherAllianceAwarded)   \t\(game.blue.total)"
    )

    game.red.auto.samplesNet = 4
    game.red.auto.samplesLow = 2
    game.red.auto.samplesHigh = 3
    game.red.auto.specimenLow = 5
    game.red.auto.specimenHigh = 1
    game.red.auto.team1Location = .aZone
    game.red.auto.team2Location = .none
    game.red.teleop.samplesNet = 9
    game.red.teleop.samplesLow = 3
    game.red.teleop.samplesHigh = 5
    game.red.teleop.specimenLow = 7
    game.red.teleop.specimenHigh = 10
    game.red.teleop.team1Location = .l2
    game.red.teleop.team2Location = .oZone
    game.red.minorFoulsFromOtherAllianceAwarded = 1
    game.red.majorFoulsFromOtherAllianceAwarded = 2

    guard game.red.auto.total == 83 else {
        throw CalculationTestErrors.wrongScore(
            "red auto",
            game.red.auto.total,
            83
        )
    }

    guard game.red.teleop.total == 230 else {
        throw CalculationTestErrors.wrongScore(
            "red teleop",
            game.red.teleop.total,
            230
        )
    }

    guard game.red.foulPointsFromOtherAllianceAwarded == 35 else {
        throw CalculationTestErrors.wrongScore(
            "red fouls",
            game.red.foulPointsFromOtherAllianceAwarded,
            35
        )
    }

    guard game.red.total == 348 else {
        throw CalculationTestErrors.wrongScore(
            "red total",
            game.red.total,
            348
        )
    }

    print(
        "red     \t\(game.red.auto.total)   \t\(game.red.teleop.total)   \t\(game.red.foulPointsFromOtherAllianceAwarded)   \t\(game.red.total)"
    )
}

@Test func calculateTest1() async throws {
    var game = IntoTheDeepGameScores()

    game.blue.auto.samplesNet = 5
    game.blue.auto.samplesLow = 9
    game.blue.auto.samplesHigh = 2
    game.blue.auto.specimenLow = 4
    game.blue.auto.specimenHigh = 11
    game.blue.auto.team1Location = .aZone
    game.blue.auto.team2Location = .none
    game.blue.teleop.samplesNet = 8
    game.blue.teleop.samplesLow = 10
    game.blue.teleop.samplesHigh = 6
    game.blue.teleop.specimenLow = 4
    game.blue.teleop.specimenHigh = 14
    game.blue.teleop.team1Location = .none
    game.blue.teleop.team2Location = .aZone
    game.blue.minorFoulsFromOtherAllianceAwarded = 0
    game.blue.majorFoulsFromOtherAllianceAwarded = 1

    guard game.blue.auto.total == 199 else {
        throw CalculationTestErrors.wrongScore(
            "blue auto",
            game.blue.auto.total,
            199
        )
    }

    guard game.blue.teleop.total == 271 else {
        throw CalculationTestErrors.wrongScore(
            "blue teleop",
            game.blue.teleop.total,
            271
        )
    }

    guard game.blue.foulPointsFromOtherAllianceAwarded == 15 else {
        throw CalculationTestErrors.wrongScore(
            "blue fouls",
            game.blue.foulPointsFromOtherAllianceAwarded,
            15
        )
    }

    guard game.blue.total == 485 else {
        throw CalculationTestErrors.wrongScore(
            "blue total",
            game.blue.total,
            485
        )
    }

    print("================================================================")
    print("alliance\tauto\tteleop\tfouls\ttotal")
    print(
        "blue    \t\(game.blue.auto.total)   \t\(game.blue.teleop.total)   \t\(game.blue.foulPointsFromOtherAllianceAwarded)   \t\(game.blue.total)"
    )

    game.red.auto.samplesNet = 3
    game.red.auto.samplesLow = 6
    game.red.auto.samplesHigh = 9
    game.red.auto.specimenLow = 2
    game.red.auto.specimenHigh = 7
    game.red.auto.team1Location = .oZone
    game.red.auto.team2Location = .aZone
    game.red.teleop.samplesNet = 5
    game.red.teleop.samplesLow = 4
    game.red.teleop.samplesHigh = 8
    game.red.teleop.specimenLow = 11
    game.red.teleop.specimenHigh = 8
    game.red.teleop.team1Location = .l2
    game.red.teleop.team2Location = .l3
    game.red.minorFoulsFromOtherAllianceAwarded = 1
    game.red.majorFoulsFromOtherAllianceAwarded = 0

    guard game.red.auto.total == 190 else {
        throw CalculationTestErrors.wrongScore(
            "red auto",
            game.red.auto.total,
            190
        )
    }

    guard game.red.teleop.total == 281 else {
        throw CalculationTestErrors.wrongScore(
            "red teleop",
            game.red.teleop.total,
            281
        )
    }

    guard game.red.foulPointsFromOtherAllianceAwarded == 5 else {
        throw CalculationTestErrors.wrongScore(
            "red fouls",
            game.red.foulPointsFromOtherAllianceAwarded,
            5
        )
    }

    guard game.red.total == 476 else {
        throw CalculationTestErrors.wrongScore(
            "red total",
            game.red.total,
            476
        )
    }

    print(
        "red     \t\(game.red.auto.total)   \t\(game.red.teleop.total)   \t\(game.red.foulPointsFromOtherAllianceAwarded)   \t\(game.red.total)"
    )
}
