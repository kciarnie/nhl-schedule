//
//  ContentView.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import SwiftData
import SwiftUI

struct ContentView: View {
	@Environment(MonthContentViewModel.self) private var viewModel
	
	@Environment(\.openWindow) var openWindow
	
	var body: some View {
		Button(viewModel.setYourTeamButton) {
			openWindow(id: "select-team")
		}
		.keyboardShortcut("r")
		if !Settings.shared.myTeam.isEmpty {
			Group {
				Divider()
				Button("Refresh") {
					Task {
						try await viewModel.load()
					}
				}
				.keyboardShortcut("r")
				
				Divider()
				
				if viewModel.games.isEmpty {
					Text("There was an error fetching the games")
				} else {
					ForEach(viewModel.games) { game in
						Button(action: {
							guard
								!game.link.isEmpty,
								let url = URL(string: game.link)
							else { return }
							NSWorkspace.shared.open(url)
						}) {
							HStack {
								Image(game.logo)
								Text(game.display)
							}
						}
					}
				}
				
				Divider()
				
				Button("Quit") {
					NSApplication.shared.terminate(nil)
				}
				.keyboardShortcut("q")
			}
			.buttonStyle(.plain)
		}
	}
}


#if DEBUG
#Preview {
	ContentView()
		.frame(width: 400, height: 60)
		.environment(TestContentViewModel())
}
#endif
