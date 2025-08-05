//
//  CalculationTestErrors.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public enum CalculationTestErrors: Error, CustomStringConvertible {
    case wrongScore(String, Int, Int)

    public var description: String {
        switch self {
        case .wrongScore(let category, let calculated, let expected):
            return
                "Failed to calculate correct score in category \(category): calculated \(calculated), expected \(expected)"
        }
    }
}
