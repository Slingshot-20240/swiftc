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
    @Attribute(.externalStorage) private var _teams: GameTeamsV1?
    @Attribute(.externalStorage) private var _scores: IntoTheDeepGameScores?
    public var timestamp: Date

    public var teams: GameTeamsV1 {
        get { _teams ?? .init() }
        set { _teams = newValue }
    }

    public var scores: IntoTheDeepGameScores {
        get { _scores ?? .init() }
        set { _scores = newValue }
    }

    public init(
        scores: IntoTheDeepGameScores,
        teams: GameTeamsV1 = .init(),
        timestamp: Date = Date()
    ) {
        self.id = UUID().uuidString
        self._teams = teams
        self._scores = scores
        self.timestamp = timestamp
    }
}
