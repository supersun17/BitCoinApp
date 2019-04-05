//
//  Constants.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

enum Endpoints: String {
	// https://api.coindesk.com/v1/bpi/currentprice.json
	case BCcurrentprice = "https://api.coindesk.com/v1/bpi/currentprice.json"
	// https://api.coindesk.com/v1/bpi/historical/close.json?start=2013-09-01&end=2013-09-05?currency=EUR
	case BChistoricalPrice = "https://api.coindesk.com/v1/bpi/historical/close.json"

	var url: URL? {
		return URL.init(string: self.rawValue)
	}

	func withQuery(_ startDate: Date, endDate: Date, currency: String) -> URL? {
		let dateConvertor = DateConvertor()
		var result = self.rawValue
		result += "?start=" + dateConvertor.dateToUTCString(startDate)
		result += "&end=" + dateConvertor.dateToUTCString(endDate)
		result += "&currency=" + currency
		return URL.init(string: result)
	}
}


