//
//  ScheduleService.swift
//  NHLSchedule
//
//  Created by Kevin Ciarniello on 04.12.23.
//

import Foundation

struct ScheduleService {
	/// The shared instance of the class
	static let shared = ScheduleService()

	private init() {}
	
	/// Fetches the schedule for a given team
	/// - Parameter team: the team's abbreviation
	/// - Returns: the schedule
	func fetchSchedule(for team: String) async throws -> ScheduleResponse {
		guard let url = URL(string: "https://api-web.nhle.com/v1/club-schedule/\(team)/month/now") else {
			throw APIError.invalidURL
		}

		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			let schedule = try decoder.decode(ScheduleResponse.self, from: data)
			return schedule
		} catch {
			throw APIError.networkError(error)
		}
	}
}
