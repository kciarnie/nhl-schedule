//
//  ContentViewModel.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import Foundation
import SwiftUI

protocol ContentViewModelProtocol {
	var schedule: ScheduleResponse? { get }
	func load() async throws
}

@Observable final class MonthContentViewModel {
	var schedule: ScheduleResponse?

	var games: [Game] = []

	init() {
		Task {
			try await load()
		}
	}

	var setYourTeamButton: String {
		Settings.shared.myTeam.isEmpty ? "Set your team" : "Set: \(Settings.shared.myTeam), Change your team"
	}

	func load() async throws {
		guard !Settings.shared.myTeam.isEmpty else {
			throw APIError.teamNotSet
		}

		guard let url = URL(string: "https://api-web.nhle.com/v1/club-schedule/\(Settings.shared.myTeam)/month/now") else {
			throw APIError.invalidURL
		}

		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			let schedule = try decoder.decode(ScheduleResponse.self, from: data)
			self.schedule = schedule
			games = schedule.games.map { $0.convert() }
		} catch {
			throw APIError.networkError(error)
		}
	}
}

enum APIError: Error {
	case invalidURL
	case networkError(Error)
	case invalidResponse
	case decodingError(Error)
	case teamNotSet
}

extension ScheduleResponse.GameResponse {
	func convert() -> Game {
		Game(
			homeTeam: homeTeam.abbrev,
			awayTeam: awayTeam.abbrev,
			startDate: gameDate,
			homeTeamLogo: homeTeam.logo,
			awayTeamLogo: awayTeam.logo,
			startTimeUTC: startTimeUTC,
			gameCenterLink: gameCenterLink
		)
	}
}
