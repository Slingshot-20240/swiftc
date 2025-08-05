//
//  FTCAPIV2.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/3/25.
//

import Foundation

public struct FTCAPIV2 {
    public var season: FTCSeason
    var endpoint: FTCAPIV2EndpointHelper

    var username: String
    var token: String

    public init(_ season: FTCSeason, username: String, token: String) async throws {
        let endpoint = FTCAPIV2EndpointHelper(season)

        let (_, _, _) = try await URLSession.shared.FTCAPIV2Fetch(
            url: endpoint.baseUrl,
            username: username,
            token: token
        )

        self.season = season
        self.endpoint = endpoint

        self.username = username
        self.token = token
    }

    public func eventAdvancements(
        at eventCode: String,
        excludeSkipped: Bool? = nil
    ) async throws -> FTCAPIV2Data.EventAdvancement {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventAdvancement(
                    at: eventCode,
                    excludeSkipped: excludeSkipped
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.EventAdvancement.self,
            from: data
        )
    }

    public func advancementSource(
        at eventCode: String,
        includeDeclines: Bool? = nil
    ) async throws -> FTCAPIV2Data.AdvancementSource {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.advancementSource(
                    at: eventCode,
                    includeDeclines: includeDeclines
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.AdvancementSource.self,
            from: data
        )
    }

    public func leagueListings(
        regionCode: String? = nil,
        leagueCode: String? = nil
    ) async throws -> FTCAPIV2Data.LeagueListings {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.leagueListings(
                    regionCode: regionCode,
                    leagueCode: leagueCode
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.LeagueListings.self,
            from: data
        )
    }

    public func leagueMembership(
        regionCode: String,
        leagueCode: String
    ) async throws -> FTCAPIV2Data.LeagueMembership {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.leagueMembership(
                    regionCode: regionCode,
                    leagueCode: leagueCode
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.LeagueMembership.self,
            from: data
        )
    }

    public func leagueRankings(
        regionCode: String,
        leagueCode: String
    ) async throws -> FTCAPIV2Data.LeagueRankings {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.leagueRankings(
                    regionCode: regionCode,
                    leagueCode: leagueCode
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.LeagueRankings.self,
            from: data
        )
    }

    public func apiIndex() async throws -> FTCAPIV2Data.APIIndex {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.apiIndex(),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.APIIndex.self,
            from: data
        )
    }

    public func seasonSummary() async throws -> FTCAPIV2Data.SeasonSummary {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.seasonSummary(),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.SeasonSummary.self,
            from: data
        )
    }

    public func eventListings(
        eventCode: String? = nil,
        teamNumber: String? = nil
    ) async throws -> FTCAPIV2Data.EventListings {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventListings(
                    eventCode: eventCode,
                    teamNumber: teamNumber
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.EventListings.self,
            from: data
        )
    }

    public func teamListings(
        teamNumber: String? = nil,
        eventCode: String? = nil,
        state: String? = nil,
        page: String? = nil
    ) async throws -> FTCAPIV2Data.TeamListings {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.teamListings(
                    teamNumber: teamNumber,
                    eventCode: eventCode,
                    state: state,
                    page: page
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.TeamListings.self,
            from: data
        )
    }

    public func hybridSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIV2Data.TournamentLevel,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIV2Data.HybridSchedule {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.hybridSchedule(
                    at: eventCode,
                    tournamentLevel: tournamentLevel,
                    start: start,
                    end: end
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.HybridSchedule.self,
            from: data
        )
    }

    public func eventSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIV2Data.TournamentLevel,
        teamNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIV2Data.EventSchedule {
        return try await self._eventSchedule(
            at: eventCode,
            tournamentLevel: tournamentLevel,
            teamNumber: teamNumber,
            start: start,
            end: end
        )
    }

    public func eventSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIV2Data.TournamentLevel? = nil,
        teamNumber: String,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIV2Data.EventSchedule {
        return try await self._eventSchedule(
            at: eventCode,
            tournamentLevel: tournamentLevel,
            teamNumber: teamNumber,
            start: start,
            end: end
        )
    }

    private func _eventSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIV2Data.TournamentLevel? = nil,
        teamNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIV2Data.EventSchedule {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventSchedule(
                    at: eventCode,
                    tournamentLevel: tournamentLevel,
                    teamNumber: teamNumber,
                    start: start,
                    end: end
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.EventSchedule.self,
            from: data
        )
    }

    public func eventRankings(
        at eventCode: String,
        teamNumber: Int? = nil,
        top: Int? = nil
    ) async throws -> FTCAPIV2Data.EventRankings {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventRankings(
                    at: eventCode,
                    teamNumber: teamNumber,
                    top: top
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.EventRankings.self,
            from: data
        )
    }

    public func eventAlliances(
        at eventCode: String,
    ) async throws -> FTCAPIV2Data.EventAlliances {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventAlliances(at: eventCode),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.EventAlliances.self,
            from: data
        )
    }

    public func allianceSelectionDetails(
        at eventCode: String,
    ) async throws -> FTCAPIV2Data.AllianceSelectionDetails {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.allianceSelectionDetails(at: eventCode),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.AllianceSelectionDetails.self,
            from: data
        )
    }

    public func eventMatchResults(
        at eventCode: String,
        tournamentLevel: FTCAPIV2Data.TournamentLevel? = nil,
        teamNumber: String? = nil,
        matchNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIV2Data.EventMatchResults {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventMatchResults(
                    at: eventCode,
                    tournamentLevel: tournamentLevel,
                    teamNumber: teamNumber,
                    matchNumber: matchNumber,
                    start: start,
                    end: end
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.EventMatchResults.self,
            from: data
        )
    }

    public func scoreDetails(
        at eventCode: String,
        tournamentLevel: FTCAPIV2Data.TournamentLevel,
        teamNumber: String? = nil,
        matchNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIV2Data.AnyScoreDetails {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.scoreDetails(
                    at: eventCode,
                    tournamentLevel: tournamentLevel,
                    teamNumber: teamNumber,
                    matchNumber: matchNumber,
                    start: start,
                    end: end
                ),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.AnyScoreDetails.decode(
            for: self.season,
            from: data
        )
    }

    public func awardListings() async throws -> FTCAPIV2Data.AwardsListing {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.awardListings(),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.AwardsListing.self,
            from: data
        )
    }

    public func teamAwards(
        for teamNumber: String,
    ) async throws -> FTCAPIV2Data.ReceivedAwards {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.teamAwards(for: teamNumber),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.ReceivedAwards.self,
            from: data
        )
    }

    public func teamEventAwards(
        at eventCode: String,
        for teamNumber: String,
    ) async throws -> FTCAPIV2Data.ReceivedAwards {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.teamEventAwards(at: eventCode, for: teamNumber),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.ReceivedAwards.self,
            from: data
        )
    }

    public func eventAwards(
        at eventCode: String,
    ) async throws -> FTCAPIV2Data.ReceivedAwards {
        let (data, _, _) = try await URLSession.shared
            .FTCAPIV2Fetch(
                url: endpoint.eventAwards(at: eventCode),
                username: username,
                token: token
            )

        return try FTCAPIV2Data.decode(
            FTCAPIV2Data.ReceivedAwards.self,
            from: data
        )
    }
}

extension URLSession {
    fileprivate func FTCAPIV2Fetch(url: URL, username: String, token: String)
        async throws -> (Data, URLResponse, Int)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let basicToken = String(format: "%@:%@", username, token).data(
            using: .utf8
        )!.base64EncodedString()
        request.setValue(
            "Basic \(basicToken)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        let httpCode = (response as? HTTPURLResponse)?.statusCode

        guard let httpCode else {
            throw FTCAPIV2Error.unableToLoad("**Failed to get HTTP status code**")
        }

        guard httpCode == 200 else {
            if httpCode == 401 {
                throw FTCAPIV2Error.unauthorized
            }

            throw FTCAPIV2Error.unableToLoad(String(httpCode))
        }

        return (data, response, httpCode)
    }
}
