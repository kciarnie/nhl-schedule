//
//  Settings.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import SwiftUI

final class Settings: ObservableObject {
	static let shared = Settings()
	private init() {}

	@AppStorage("myTEAM") var myTeam = ""
}
