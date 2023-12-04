//
//  ScheduleResponse.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import Foundation

// MARK: - Schedule

struct ScheduleResponse: Codable {
	let games: [GameResponse]

	struct GameResponse: Codable {
		let gameType: Int
		let gameDate: String

		let venue: Venue

		// MARK: - Venue

		struct Venue: Codable {
			let `default`: String
		}

		let startTimeUTC: String
		let gameState: GameState

		enum GameState: String, Codable {
			case future = "FUT"
			case official = "OFF"
			case final = "FINAL"
		}

		let awayTeam: Team
		let homeTeam: Team

		struct Team: Codable {
			let id: Int
			let placeName: PlaceName
			let abbrev: String
			let logo, darkLogo: String
			let awaySplitSquad: Bool?
			let score: Int?
			let airlineLink: String?
			let airlineDesc: String?
			let hotelLink: String?
			let hotelDesc: String?
			let radioLink: String?
			let homeSplitSquad: Bool?
		}

		struct PlaceName: Codable {
			let `default`: String
		}

		let gameOutcome: GameOutcome?

		struct GameOutcome: Codable {
			let lastPeriodType: String
		}

		let gameCenterLink: String?
	}
}
