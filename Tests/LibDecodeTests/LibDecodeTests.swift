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

struct TestData: Codable, Hashable, Sendable {

}

let url = Bundle.module.url(
    forResource: "LibDecodeTestData",
    withExtension: "json"
)!
let fileData = try! Data(contentsOf: url)
let testData = try! JSONDecoder().decode(TestData.self, from: fileData)

@Test func calculateTest0() async throws {
    var game = DecodeGameScores()
    
    game.blue.auto.classfied = 7
    game.blue.auto.overflown = 5
    game.blue.auto.matchingMotifs = 3
    game.blue.auto.team1Location = .left
    game.blue.auto.team2Location = .none
    
    
    game.blue.teleop.classfied = 2
    game.blue.teleop.overflown = 3
    game.blue.teleop.depot = 2
    game.blue.teleop.matchingMotifs = 0
    game.blue.teleop.team1Location = .partial
    game.blue.teleop.team2Location = .full
    
    game.blue.minorFoulsFromOtherAllianceAwarded = 0
    game.blue.majorFoulsFromOtherAllianceAwarded = 1

    guard game.blue.auto.total == 35 else {
        throw CalculationTestErrors.wrongScore(
            "blue auto",
            game.blue.auto.total,
            35
        )
    }

    guard game.blue.teleop.total == 26 else {
        throw CalculationTestErrors.wrongScore(
            "blue teleop",
            game.blue.teleop.total,
            26
        )
    }

    guard game.blue.foulPointsFromOtherAllianceAwarded == 15 else {
        throw CalculationTestErrors.wrongScore(
            "blue fouls",
            game.blue.foulPointsFromOtherAllianceAwarded,
            15
        )
    }

    guard game.blue.total == 76 else {
        throw CalculationTestErrors.wrongScore(
            "blue total",
            game.blue.total,
            76
        )
    }

    print("================================================================")
    print("alliance\tauto\tteleop\tfouls\ttotal")
    print(
        "blue    \t\(game.blue.auto.total)   \t\(game.blue.teleop.total)   \t\(game.blue.foulPointsFromOtherAllianceAwarded)   \t\(game.blue.total)"
    )

    
    game.red.auto.classfied = 3
    game.red.auto.overflown = 0
    game.red.auto.matchingMotifs = 3
    game.red.auto.team1Location = .left
    game.red.auto.team2Location = .none
    
    
    game.red.teleop.classfied = 3
    game.red.teleop.overflown = 6
    game.red.teleop.depot = 4
    game.red.teleop.matchingMotifs = 2
    game.red.teleop.team1Location = .partial
    game.red.teleop.team2Location = .none
    
    game.red.minorFoulsFromOtherAllianceAwarded = 0
    game.red.majorFoulsFromOtherAllianceAwarded = 0

    guard game.red.auto.total == 18 else {
        throw CalculationTestErrors.wrongScore(
            "red auto",
            game.red.auto.total,
            18
        )
    }

    guard game.red.teleop.total == 28 else {
        throw CalculationTestErrors.wrongScore(
            "red teleop",
            game.red.teleop.total,
            28
        )
    }

    guard game.red.foulPointsFromOtherAllianceAwarded == 0 else {
        throw CalculationTestErrors.wrongScore(
            "red fouls",
            game.red.foulPointsFromOtherAllianceAwarded,
            0
        )
    }

    guard game.red.total == 46 else {
        throw CalculationTestErrors.wrongScore(
            "red total",
            game.red.total,
            46
        )
    }

    print(
        "red     \t\(game.red.auto.total)   \t\(game.red.teleop.total)   \t\(game.red.foulPointsFromOtherAllianceAwarded)   \t\(game.red.total)"
    )
}

@Test func calculateTest1() async throws {
    var game = DecodeGameScores()
    
    game.blue.auto.classfied = 8
    game.blue.auto.overflown = 2
    game.blue.auto.matchingMotifs = 4
    game.blue.auto.team1Location = .left
    game.blue.auto.team2Location = .left
    
    
    game.blue.teleop.classfied = 20
    game.blue.teleop.overflown = 4
    game.blue.teleop.depot = 1
    game.blue.teleop.matchingMotifs = 4
    game.blue.teleop.team1Location = .full
    game.blue.teleop.team2Location = .full
    
    game.blue.minorFoulsFromOtherAllianceAwarded = 0
    game.blue.majorFoulsFromOtherAllianceAwarded = 1

    guard game.blue.auto.total == 40 else {
        throw CalculationTestErrors.wrongScore(
            "blue auto",
            game.blue.auto.total,
            40
        )
    }

    guard game.blue.teleop.total == 103 else {
        throw CalculationTestErrors.wrongScore(
            "blue teleop",
            game.blue.teleop.total,
            103
        )
    }

    guard game.blue.foulPointsFromOtherAllianceAwarded == 15 else {
        throw CalculationTestErrors.wrongScore(
            "blue fouls",
            game.blue.foulPointsFromOtherAllianceAwarded,
            15
        )
    }

    guard game.blue.total == 158 else {
        throw CalculationTestErrors.wrongScore(
            "blue total",
            game.blue.total,
            158
        )
    }

    print("================================================================")
    print("alliance\tauto\tteleop\tfouls\ttotal")
    print(
        "blue    \t\(game.blue.auto.total)   \t\(game.blue.teleop.total)   \t\(game.blue.foulPointsFromOtherAllianceAwarded)   \t\(game.blue.total)"
    )

    
    game.red.auto.classfied = 9
    game.red.auto.overflown = 2
    game.red.auto.matchingMotifs = 5
    game.red.auto.team1Location = .left
    game.red.auto.team2Location = .left
    
    
    game.red.teleop.classfied = 25
    game.red.teleop.overflown = 5
    game.red.teleop.depot = 1
    game.red.teleop.matchingMotifs = 7
    game.red.teleop.team1Location = .none
    game.red.teleop.team2Location = .full
    
    game.red.minorFoulsFromOtherAllianceAwarded = 1
    game.red.majorFoulsFromOtherAllianceAwarded = 0

    guard game.red.auto.total == 45 else {
        throw CalculationTestErrors.wrongScore(
            "red auto",
            game.red.auto.total,
            45
        )
    }

    guard game.red.teleop.total == 105 else {
        throw CalculationTestErrors.wrongScore(
            "red teleop",
            game.red.teleop.total,
            105
        )
    }

    guard game.red.foulPointsFromOtherAllianceAwarded == 5 else {
        throw CalculationTestErrors.wrongScore(
            "red fouls",
            game.red.foulPointsFromOtherAllianceAwarded,
            5
        )
    }

    guard game.red.total == 155 else {
        throw CalculationTestErrors.wrongScore(
            "red total",
            game.red.total,
            155
        )
    }

    print(
        "red     \t\(game.red.auto.total)   \t\(game.red.teleop.total)   \t\(game.red.foulPointsFromOtherAllianceAwarded)   \t\(game.red.total)"
    )
}
