//
//  GameTeamsV1.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct GameTeamsV1: Codable, Hashable {
    public var blue: AllianceTeams
    public var red: AllianceTeams

    public init() {
        self.blue = .init()
        self.red = .init()
    }

    public struct AllianceTeams: Codable, Hashable {
        public var one: String?
        public var two: String?

        init() {
            self.one = nil
            self.two = nil
        }
    }
}
