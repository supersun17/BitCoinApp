//
//  Helpers.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

class DateConvertor {
	let UTCformatter: DateFormatter
	init() {
		let fmt = DateFormatter.init()
		fmt.dateFormat = "yyyy-MM-dd"
		fmt.timeZone = TimeZone.init(secondsFromGMT: 0)
		UTCformatter = fmt
	}

	func dateToUTCString(_ date: Date) -> String {
		return UTCformatter.string(from: date)
	}
}
