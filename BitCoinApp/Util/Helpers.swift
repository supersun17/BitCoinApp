//
//  Helpers.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

class DateConvertor {
	let formatter: DateFormatter = DateFormatter()
	init() {
	}

	func dateToUTCString(_ date: Date) -> String {
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
		return formatter.string(from: date)
	}

	func dateToAMPMTimeString(_ date: Date) -> String {
		formatter.dateFormat = "hh:mm:ss a"
		formatter.timeZone = TimeZone.current
		return formatter.string(from: date)
	}
}

extension String {
	var decoded: String? {
		guard let data = self.data(using: .utf8) else { return nil }

		let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
			NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
			NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
		]

		guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
			return nil
		}

		return String(attributedString.string)
	}

}
