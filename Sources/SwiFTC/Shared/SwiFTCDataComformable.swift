
//
//  SwiFTCDataConformable.swift
//  SwiFTC
//
//  Created by Jining Liu on 9/12/25.
//

import Foundation

public protocol SwiFTCDataConformable: Codable, Hashable, RawRepresentable where RawValue == String {}

public extension SwiFTCDataConformable {
    var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        return string
    }
    
    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let decoded = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        self = decoded
    }
}
