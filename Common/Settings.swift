//
//  Settings.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import SwiftUI


/// This class is used to store the user's favorite team
final class Settings: ObservableObject {
	
	/// The shared instance of the class
	static let shared = Settings()

	private init() {}

	/// The user's favorite team
	@AppStorage("myTEAM") var myTeam = ""
}
