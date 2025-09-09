//
//  GameLabel.swift
//  SwiFTC
//
//  Created by Jining Liu on 9/8/25.
//

import Foundation

public struct GameLabel {
    public var red: String
    public var middle: String
    public var blue: String
    
    public init(red: String, middle: String, blue: String) {
        self.red = red
        self.middle = middle
        self.blue = blue
    }
    
    public init() {
        self.red = ""
        self.middle = "Game"
        self.blue = ""
    }
}
