//
//  TestContentViewModel.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import Foundation
import SwiftUI

@Observable final class TestContentViewModel {
	var schedule: ScheduleResponse?

	var games: [Game] = []

	init() {
		Task {
			try await load()
		}
	}

	func load() async throws {
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYY-MM-DD"

		let url = URL.testData
		let data = try Data(contentsOf: url)
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(formatter)
		let schedule = try decoder.decode(ScheduleResponse.self, from: data)
		self.schedule = schedule
		games = schedule.games.map { $0.convert() }
	}
}
