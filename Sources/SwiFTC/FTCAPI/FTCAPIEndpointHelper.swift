//
//  FTCAPIEndpointHelper.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/4/25.
//

import Foundation

struct FTCAPIEndpointHelper {

    let season: FTCSeason
    let baseUrl: URL

    init(_ season: FTCSeason) {
        self.season = season
        self.baseUrl = .init(
            string: "https://ftc-api.firstinspires.org/v2.0/\(season.year)"
        )!
    }

    func eventAdvancement(
        at eventCode: String,
        excludeSkipped: Bool? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let excludeSkipped {
            parameters["excludeSkipped"] = excludeSkipped
        }

        return self.baseUrl.appendingPaths(["advancement", eventCode])
            .appendingQueryParameters(parameters)
    }

    func advancementSource(
        at eventCode: String,
        includeDeclines: Bool? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let includeDeclines {
            parameters["includeDeclines"] = includeDeclines
        }

        return self.baseUrl.appendingPaths(["advancement", eventCode, "source"])
            .appendingQueryParameters(parameters)
    }

    func leagueListings(
        regionCode: String? = nil,
        leagueCode: String? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let regionCode {
            parameters["regionCode"] = regionCode
        }

        if let leagueCode {
            parameters["leagueCode"] = leagueCode
        }

        return self.baseUrl.appendingPaths(["leagues"])
            .appendingQueryParameters(parameters)
    }

    func leagueMembership(
        regionCode: String,
        leagueCode: String
    ) -> URL {
        return self.baseUrl.appendingPaths([
            "leagues", "members", regionCode, leagueCode,
        ])
    }

    func leagueRankings(
        regionCode: String,
        leagueCode: String
    ) -> URL {
        return self.baseUrl.appendingPaths([
            "leagues", "rankings", regionCode, leagueCode,
        ])
    }

    func apiIndex() -> URL {
        return self.baseUrl.deletingLastPathComponent()
    }

    func seasonSummary() -> URL {
        return self.baseUrl
    }

    func eventListings(
        eventCode: String? = nil,
        teamNumber: String? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let eventCode {
            parameters["eventCode"] = eventCode
        }

        if let teamNumber {
            parameters["teamNumber"] = teamNumber
        }

        return self.baseUrl.appendingPaths(["events"])
            .appendingQueryParameters(parameters)
    }

    func teamListings(
        teamNumber: String? = nil,
        eventCode: String? = nil,
        state: String? = nil,
        page: String? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let teamNumber {
            parameters["teamNumber"] = teamNumber
        }

        if let eventCode {
            parameters["eventCode"] = eventCode
        }

        if let state {
            parameters["state"] = state
        }

        if let page {
            parameters["page"] = page
        }

        return self.baseUrl.appendingPaths(["teams"])
            .appendingQueryParameters(parameters)
    }

    func hybridSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel,
        start: Int? = nil,
        end: Int? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let start {
            parameters["start"] = start
        }

        if let end {
            parameters["end"] = end
        }

        return self.baseUrl.appendingPaths([
            "schedule", eventCode, tournamentLevel.parameterValue, "hybrid",
        ])
        .appendingQueryParameters(parameters)
    }

    func eventSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel? = nil,
        teamNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let tournamentLevel {
            parameters["tournamentLevel"] = tournamentLevel.parameterValue
        }

        if let teamNumber {
            parameters["teamNumber"] = teamNumber
        }

        if let start {
            parameters["start"] = start
        }

        if let end {
            parameters["end"] = end
        }

        return self.baseUrl.appendingPaths([
            "schedule", eventCode,
        ])
        .appendingQueryParameters(parameters)
    }

    func eventRankings(
        at eventCode: String,
        teamNumber: Int? = nil,
        top: Int? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let teamNumber {
            parameters["teamNumber"] = teamNumber
        }

        if let top {
            parameters["top"] = top
        }

        return self.baseUrl.appendingPaths(["rankings", eventCode])
            .appendingQueryParameters(parameters)
    }

    func eventAlliances(
        at eventCode: String
    ) -> URL {
        return self.baseUrl.appendingPaths(["alliances", eventCode])
    }

    func allianceSelectionDetails(
        at eventCode: String
    ) -> URL {
        return self.baseUrl.appendingPaths([
            "alliances", eventCode, "selection",
        ])
    }

    func eventMatchResults(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel? = nil,
        teamNumber: String? = nil,
        matchNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let tournamentLevel {
            parameters["tournamentLevel"] = tournamentLevel.parameterValue
        }

        if let teamNumber {
            parameters["teamNumber"] = teamNumber
        }

        if let matchNumber {
            parameters["matchNumber"] = matchNumber
        }

        if let start {
            parameters["start"] = start
        }

        if let end {
            parameters["end"] = end
        }

        return self.baseUrl.appendingPaths([
            "matches", eventCode,
        ])
        .appendingQueryParameters(parameters)
    }

    func scoreDetails(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel,
        teamNumber: String? = nil,
        matchNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) -> URL {
        var parameters: [String: Any] = [:]

        if let teamNumber {
            parameters["teamNumber"] = teamNumber
        }

        if let matchNumber {
            parameters["matchNumber"] = matchNumber
        }

        if let start {
            parameters["start"] = start
        }

        if let end {
            parameters["end"] = end
        }

        return self.baseUrl.appendingPaths([
            "scores", eventCode, tournamentLevel.parameterValue,
        ])
        .appendingQueryParameters(parameters)
    }
    
    func awardListings() -> URL {
        return self.baseUrl.appendingPaths(["awards", "list"])
    }
    
    func teamAwards(
        for teamNumber: String
    ) -> URL {
        return self.baseUrl.appendingPaths(["awards", teamNumber])
    }
    
    func teamEventAwards(
        at eventCode: String,
        for teamNumber: String
    ) -> URL {
        return self.baseUrl.appendingPaths(["awards", eventCode, teamNumber])
    }
    
    func eventAwards(
        at eventCode: String
    ) -> URL {
        return self.baseUrl.appendingPaths(["awards", eventCode])
    }
}

extension URL {
    fileprivate func appendingPaths(_ paths: [String]) -> URL {
        var url = self
        for path in paths {
            url = url.appendingPathComponent(path)
        }
        return url
    }

    fileprivate func appendingQueryParameters(_ parameters: [String: Any])
        -> URL
    {
        var components = URLComponents(
            url: self,
            resolvingAgainstBaseURL: true
        )!
        components.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        return components.url!
    }
}
