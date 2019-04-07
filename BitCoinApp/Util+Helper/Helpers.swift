//
//  Helpers.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

/**
Convert Swift Date to formatted String, vice versa.
**/
class DateConvertor {
	let formatter: DateFormatter = DateFormatter()
	init() {}

	/**
	Convert Date to UTC formatted Date String.
	- Parameters:
		- date: Swift Date
		- formatString: the prefered format string, default is yyyy-MM-dd
	- Returns: Date String
	**/
	func dateToUTCString(_ date: Date, formatString: String = "yyyy-MM-dd") -> String {
		formatter.dateFormat = formatString
		formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
		return formatter.string(from: date)
	}

	/**
	Convert Date to AM PM formatted Time String.
	- Parameters:
		- date: Swift Date
		- formatString: AM PM format time, default is hh:mm:ss a
	- Returns: Time String
	**/
	func dateToAMPMTimeString(_ date: Date) -> String {
		formatter.dateFormat = "hh:mm:ss a"
		formatter.timeZone = TimeZone.current
		return formatter.string(from: date)
	}
}

extension String {
	/**
	If the symbol is a html encoded String like "&EURO;", use this variable to retreive the corresponding decoded symbol. The return type is a optional.
	**/
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

extension Double {
	var twoDigitsAccuracyString: String {
		return String(format: "%.2f", self)
	}
}
