//
//  Game.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Game {
	@Attribute(.unique) var id = UUID()

	let homeTeam: String
	let awayTeam: String

	let startDate: String

	let homeTeamLogo: String
	let awayTeamLogo: String
	let startTimeUTC: String

	let gameCenterLink: String?


	init(homeTeam: String, awayTeam: String, startDate: String, homeTeamLogo: String, awayTeamLogo: String, startTimeUTC: String, gameCenterLink: String?) {
		self.homeTeam = homeTeam
		self.awayTeam = awayTeam
		self.startDate = startDate
		self.homeTeamLogo = homeTeamLogo
		self.awayTeamLogo = awayTeamLogo
		self.startTimeUTC = startTimeUTC
		self.gameCenterLink = gameCenterLink
	}

	func getLogo(url: String) -> String {
		url.split(separator: "/").last?.replacingOccurrences(of: "_light.svg", with: "") ?? ""
	}

	var isHomeGame: Bool {
		homeTeam == Settings.shared.myTeam
	}

	var logo: String {
		getLogo(url: "logos/\(isHomeGame ? awayTeamLogo : homeTeamLogo)")
	}

	var dateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.locale = Locale.current
		dateFormatter.timeZone = TimeZone.current
		return dateFormatter
	}

	var date: String {
		let dateFormatter = dateFormatter
		if let inputDate = dateFormatter.date(from: startTimeUTC) {
			dateFormatter.dateFormat = "dd.MM.yyyy"
			return dateFormatter.string(from: inputDate)
		} else {
			print("Error parsing date")
			return ""
		}
	}

	var time: String {
		let dateFormatter = dateFormatter
		if let inputDate = dateFormatter.date(from: startTimeUTC) {
			dateFormatter.dateFormat = "h:mm a zzz"
			return dateFormatter.string(from: inputDate)
		} else {
			print("Error parsing date")
			return ""
		}
	}

	var gameType: String {
		isHomeGame ? "(HOME)" : "(AWAY)"
	}

	var display: String {
		"\(date) \(awayTeam) VS \(homeTeam) \(time) \(gameType)"
	}

	/// NHL.com link to game center
	var link: String {
		guard let gameCenterLink else { return "" }
		return "https://www.nhl.com\(gameCenterLink)"
	}
}
