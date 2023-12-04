//
//  NHLScheduleApp.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import SwiftData
import SwiftUI

@main
struct NHLScheduleApp: App {
	var sharedModelContainer: ModelContainer = {
		let schema = Schema([
			Game.self
		])
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

		do {
			return try ModelContainer(for: schema, configurations: [modelConfiguration])
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()

	@State var viewModel = MonthContentViewModel()

	var body: some Scene {
		MenuBarExtra {
			ContentView()
				.modelContainer(sharedModelContainer)
				.environment(viewModel)
		} label: {
			Image(.menubarIcon)
		}
		.menuBarExtraStyle(.menu)

		Window("Select your team", id: "select-team") {
			SelectTeamView()
				.environment(viewModel)
		}
	}
}
