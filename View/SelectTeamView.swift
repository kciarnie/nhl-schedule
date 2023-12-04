//
//  SelectTeamView.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import SwiftUI

struct SelectTeamView: View {
	@Environment(MonthContentViewModel.self) private var viewModel

	let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)

	var body: some View {
		ScrollView(.horizontal) {
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(Teams.all, id: \.self) { team in
					TeamItemView(team: team)
				}
			}
			.padding()
		}
		.frame(width: 420, height: 650)
	}
}

struct TeamItemView: View {
	let team: String

	let size: CGFloat = 50

	@Environment(MonthContentViewModel.self) private var viewModel

	@Environment(\.dismiss) var dismiss

	var body: some View {
		Image(team, bundle: .main)
			.resizable()
			.scaledToFit()
			.frame(width: size, height: size)
			.padding(.all, 10)
			.background(Color(NSColor.controlBackgroundColor))
			.clipShape(Circle())
			.onTapGesture {
				Settings.shared.myTeam = team.uppercased()
				Task {
					try await viewModel.load()
				}
				dismiss()
			}
	}
}

#Preview {
	SelectTeamView()
		.environment(MonthContentViewModel())
}
