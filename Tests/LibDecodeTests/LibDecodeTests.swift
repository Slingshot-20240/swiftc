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
    game.blue.auto.team1Location = .leave
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
    game.red.auto.team1Location = .leave
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
