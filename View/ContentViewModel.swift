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

	let service = ScheduleService.shared

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

		do {
			let schedule = try await service.fetchSchedule(for: Settings.shared.myTeam)
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
