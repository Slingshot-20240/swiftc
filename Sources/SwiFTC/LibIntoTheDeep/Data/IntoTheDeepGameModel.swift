//
//  IntoTheDeepGameModel.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation
import SwiftData

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
@Model
public final class IntoTheDeepGameModel {
    public var id: String
    var teams: GameTeamsV1
    var scores: IntoTheDeepGameScores

    init(scores: IntoTheDeepGameScores, teams: GameTeamsV1 = .init()) {
        self.id = UUID().uuidString
        self.teams = teams
        self.scores = scores
    }
}
