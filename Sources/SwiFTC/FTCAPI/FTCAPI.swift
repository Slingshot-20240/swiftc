//
//  FTCAPI.swift
//  SwiFTC
//
//  Created by Jining Liu on 8/3/25.
//

import Foundation

public struct FTCAPI {
    var season: FTCSeason
    var endpoint: FTCAPIEndpointHelper

    var username: String
    var token: String

    init(_ season: FTCSeason, username: String, token: String) async throws {
        let endpoint = FTCAPIEndpointHelper(season)

        let (_, _, _) = try await URLSession.shared.ftcApiFetch(
            url: endpoint.baseUrl,
            username: username,
            token: token
        )

        self.season = season
        self.endpoint = endpoint

        self.username = username
        self.token = token
    }

    func eventAdvancements(
        at eventCode: String,
        excludeSkipped: Bool? = nil
    ) async throws -> FTCAPIData.EventAdvancement {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.eventAdvancement(
                    at: eventCode,
                    excludeSkipped: excludeSkipped
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.EventAdvancement.self,
            from: data
        )
    }

    func advancementSource(
        at eventCode: String,
        includeDeclines: Bool? = nil
    ) async throws -> FTCAPIData.AdvancementSource {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.advancementSource(
                    at: eventCode,
                    includeDeclines: includeDeclines
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.AdvancementSource.self,
            from: data
        )
    }

    func leagueListings(
        regionCode: String? = nil,
        leagueCode: String? = nil
    ) async throws -> FTCAPIData.LeagueListings {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.leagueListings(
                    regionCode: regionCode,
                    leagueCode: leagueCode
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.LeagueListings.self,
            from: data
        )
    }

    func leagueMembership(
        regionCode: String,
        leagueCode: String
    ) async throws -> FTCAPIData.LeagueMembership {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.leagueMembership(
                    regionCode: regionCode,
                    leagueCode: leagueCode
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.LeagueMembership.self,
            from: data
        )
    }

    func leagueRankings(
        regionCode: String,
        leagueCode: String
    ) async throws -> FTCAPIData.LeagueRankings {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.leagueRankings(
                    regionCode: regionCode,
                    leagueCode: leagueCode
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.LeagueRankings.self,
            from: data
        )
    }

    func apiIndex() async throws -> FTCAPIData.APIIndex {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.apiIndex(),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.APIIndex.self,
            from: data
        )
    }

    func seasonSummary() async throws -> FTCAPIData.SeasonSummary {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.seasonSummary(),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.SeasonSummary.self,
            from: data
        )
    }

    func eventListings(
        eventCode: String? = nil,
        teamNumber: String? = nil
    ) async throws -> FTCAPIData.EventListings {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.eventListings(
                    eventCode: eventCode,
                    teamNumber: teamNumber
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.EventListings.self,
            from: data
        )
    }

    func teamListings(
        teamNumber: String? = nil,
        eventCode: String? = nil,
        state: String? = nil,
        page: String? = nil
    ) async throws -> FTCAPIData.TeamListings {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.teamListings(
                    teamNumber: teamNumber,
                    eventCode: eventCode,
                    state: state,
                    page: page
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.TeamListings.self,
            from: data
        )
    }

    func hybridSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIData.HybridSchedule {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.hybridSchedule(
                    at: eventCode,
                    tournamentLevel: tournamentLevel,
                    start: start,
                    end: end
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.HybridSchedule.self,
            from: data
        )
    }

    func eventSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel,
        teamNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIData.EventSchedule {
        return try await self._eventSchedule(
            at: eventCode,
            tournamentLevel: tournamentLevel,
            teamNumber: teamNumber,
            start: start,
            end: end
        )
    }

    func eventSchedule(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel? = nil,
        teamNumber: String,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIData.EventSchedule {
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
        tournamentLevel: FTCAPIData.TournamentLevel? = nil,
        teamNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIData.EventSchedule {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
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

        return try FTCAPIData.decode(
            FTCAPIData.EventSchedule.self,
            from: data
        )
    }

    func eventRankings(
        at eventCode: String,
        teamNumber: Int? = nil,
        top: Int? = nil
    ) async throws -> FTCAPIData.EventRankings {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.eventRankings(
                    at: eventCode,
                    teamNumber: teamNumber,
                    top: top
                ),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.EventRankings.self,
            from: data
        )
    }

    func eventAlliances(
        at eventCode: String,
    ) async throws -> FTCAPIData.EventAlliances {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.eventAlliances(at: eventCode),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.EventAlliances.self,
            from: data
        )
    }

    func allianceSelectionDetails(
        at eventCode: String,
    ) async throws -> FTCAPIData.AllianceSelectionDetails {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.allianceSelectionDetails(at: eventCode),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.AllianceSelectionDetails.self,
            from: data
        )
    }

    func eventMatchResults(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel? = nil,
        teamNumber: String? = nil,
        matchNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIData.EventMatchResults {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
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

        return try FTCAPIData.decode(
            FTCAPIData.EventMatchResults.self,
            from: data
        )
    }

    func scoreDetails(
        at eventCode: String,
        tournamentLevel: FTCAPIData.TournamentLevel,
        teamNumber: String? = nil,
        matchNumber: String? = nil,
        start: Int? = nil,
        end: Int? = nil
    ) async throws -> FTCAPIData.AnyScoreDetails {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
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

        return try FTCAPIData.AnyScoreDetails.decode(
            for: self.season,
            from: data
        )
    }

    func awardListings() async throws -> FTCAPIData.AwardsListing {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.awardListings(),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.AwardsListing.self,
            from: data
        )
    }

    func teamAwards(
        for teamNumber: String,
    ) async throws -> FTCAPIData.ReceivedAwards {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.teamAwards(for: teamNumber),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.ReceivedAwards.self,
            from: data
        )
    }

    func teamEventAwards(
        at eventCode: String,
        for teamNumber: String,
    ) async throws -> FTCAPIData.ReceivedAwards {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.teamEventAwards(at: eventCode, for: teamNumber),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.ReceivedAwards.self,
            from: data
        )
    }

    func eventAwards(
        at eventCode: String,
    ) async throws -> FTCAPIData.ReceivedAwards {
        let (data, _, _) = try await URLSession.shared
            .ftcApiFetch(
                url: endpoint.eventAwards(at: eventCode),
                username: username,
                token: token
            )

        return try FTCAPIData.decode(
            FTCAPIData.ReceivedAwards.self,
            from: data
        )
    }
}

extension URLSession {
    fileprivate func ftcApiFetch(url: URL, username: String, token: String)
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
            throw FTCAPIError.unableToLoad("**Failed to get HTTP status code**")
        }

        guard httpCode == 200 else {
            if httpCode == 401 {
                throw FTCAPIError.unauthorized
            }

            throw FTCAPIError.unableToLoad(String(httpCode))
        }

        return (data, response, httpCode)
    }
}
