//
//  FTCAPIError.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

public enum FTCAPIError: Error, CustomStringConvertible, Equatable {

    case unauthorized
    case unableToLoad(String)
    case noData

    public var description: String {
        switch self {
        case .unauthorized:
            return
                "Received HTTP 401 Unauthorized response from the FTC API server. Please check your credentials."
        case .unableToLoad(let code):
            return
                "Received HTTP code \(code) from the FTC API server. The request made to the FTC API server was unsuccessful."
        case .noData:
            return
                "No data was returned from the FTC API server. This may be a bug in the SwiFTC library. Please report the issue on GitHub."
        }
    }
}
