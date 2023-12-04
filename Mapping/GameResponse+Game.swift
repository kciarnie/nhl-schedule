//
//  GameResponse+Game.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import Foundation

extension ScheduleResponse.GameResponse {
	/// Converts a `GameResponse` to a `Game`
	/// - Returns: A `Game` object
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
