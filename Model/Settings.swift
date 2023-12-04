//
//  Settings.swift
//  NHLSchedule
//
//  Created by Kevin Ciarniello on 04.12.23.
//

import SwiftUI

final class Settings: ObservableObject {
	static let shared = Settings()
	private init() { }
	
	@AppStorage("myTEAM") var myTeam = ""
}
