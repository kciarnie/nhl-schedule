//
//  GameResponse+Game.swift
//  NHLSchedule
//
//  Created by Kevin Ciarniello on 04.12.23.
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
