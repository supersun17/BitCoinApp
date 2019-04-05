//
//  BitCoinServiceHandler.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

/**
Handles BitCoin API service
**/
class BitCoinServiceHandler {
	/**
	Request data for today, from coindesk API
	- Parameters:
		- completion: closure to execute when result has been retreived. A BitCoinRecord optional will be passed as argument.
	- Returns: void
	**/
	func requestDataForToday(completion: @escaping (_ recoard: BitCoinRecord?) -> Void) {
		guard let url = Endpoints.BCcurrentprice.url else { return }
		WebserviceHandler.request(withURL: url, method: .get) { data in
			completion(BitCoinRecord.factory(data: data))
		}
	}

	/**
	Request data for historical prices, from coindesk API
	- Parameters:
		- startDate: start date in local timezone
		- endDate: end date in local timezone
		- currency: it can be USD, EUR, GBP
		- completion: closure to execute when result has been retreived. A HistoricalBPIRecord optional will be passed as argument.
	- Returns: void
	**/
	func requestHistoryData(_ startDate: Date, endDate: Date, currency: String, completion: @escaping (_ records: HistoricalBPIRecord?) -> Void) {
		guard let url = Endpoints.BChistoricalPrice.withQuery(startDate, endDate: endDate, currency: currency) else { return }
		WebserviceHandler.request(withURL: url, method: .get) { data in
			completion(HistoricalBPIRecord.factory(data: data))
		}
	}
}
