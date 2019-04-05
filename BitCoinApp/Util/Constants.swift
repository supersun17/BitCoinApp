//
//  Constants.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation
/**
API service endpoints
use .BCcurrentprice for current Bitcoin price
use .BChitoricalPrice for hitorical price. The default URL returns 31 days USD prices history
**/
enum Endpoints: String {
	// https://api.coindesk.com/v1/bpi/currentprice.json
	case BCcurrentprice = "https://api.coindesk.com/v1/bpi/currentprice.json"
	// https://api.coindesk.com/v1/bpi/historical/close.json?start=2013-09-01&end=2013-09-05?currency=EUR
	case BChistoricalPrice = "https://api.coindesk.com/v1/bpi/historical/close.json"

	/**
	returns optional URL
	**/
	var url: URL? {
		return URL.init(string: self.rawValue)
	}

	/**
	Specify the time period and currency you interested in.
	- Parameters:
		- startDate: start date in local timezone
		- endDate: end date in local timezone
		- currency: it can be USD, EUR, GBP
	- Returns: optional URL
	**/
	func withQuery(_ startDate: Date, endDate: Date, currency: String) -> URL? {
		let dateConvertor = DateConvertor()
		var result = self.rawValue
		result += "?start=" + dateConvertor.dateToUTCString(startDate)
		result += "&end=" + dateConvertor.dateToUTCString(endDate)
		result += "&currency=" + currency
		return URL.init(string: result)
	}
}

struct TimingConstants {
	static let BCAPIRequestInterval: TimeInterval = 60
	static let BCDisplayRefreshInterval: TimeInterval = 10
}

