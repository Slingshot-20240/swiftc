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

    public var teams: GameTeamsV1 {
        get { _teams ?? .init() }
        set { _teams = newValue }
    }

    public var scores: IntoTheDeepGameScores {
        get { _scores ?? .init() }
        set { _scores = newValue }
    }
    
    public var label: GameLabel {
        let red1 = self.teams.red.one
        let red2 = self.teams.red.two

        let redLabel: String
        if let r1 = red1, let r2 = red2 {
            redLabel = "\(r1) & \(r2)"
        } else if let r1 = red1 {
            redLabel = "\(r1) & Team"
        } else if let r2 = red2 {
            redLabel = "Team & \(r2)"
        } else {
            redLabel = "Red Alliance"
        }

        let blue1 = self.teams.blue.one
        let blue2 = self.teams.blue.two

        let blueLabel: String
        if let b1 = blue1, let b2 = blue2 {
            blueLabel = "\(b1) & \(b2)"
        } else if let b1 = blue1 {
            blueLabel = "\(b1) & Team"
        } else if let b2 = blue2 {
            blueLabel = "Team & \(b2)"
        } else {
            blueLabel = "Blue Alliance"
        }

        if red1 == nil && red2 == nil && blue1 == nil
            && blue2 == nil
        {
            return .init()
        }

        return .init(red: redLabel, middle: " v.s. ", blue: blueLabel)
    }
}
