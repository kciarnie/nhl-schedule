//
//  Previews+URL.swift
//  NHL Schedule
//
//  Copyright © 2023 Kevin Ciarniello. All rights reserved.
//

import Foundation

extension URL {
	/// This creates a URL instance of the `test.json` file
	static var testData: URL {
		let filename = "test"
		guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
			fatalError("Failed to locate preview file \(filename).json")
		}
		return url
	}
}

extension ScheduleResponse {
	static var testData: ScheduleResponse? {
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYY-MM-DD"

		let url = URL.testData
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .formatted(formatter)
			return try decoder.decode(ScheduleResponse.self, from: data)
		} catch {
			print("Error decoding JSON: \(error)")
		}
		return nil
	}
}
