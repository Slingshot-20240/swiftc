//
//  GameTeamsV1.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public struct GameTeamsV1: Codable {
    var blue: AllianceTeams
    var red: AllianceTeams

    init() {
        self.blue = .init()
        self.red = .init()
    }

    struct AllianceTeams: Codable {
        var one: String?
        var two: String?

        init() {
            self.one = nil
            self.two = nil
        }
    }
}
