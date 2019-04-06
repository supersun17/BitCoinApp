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
class BitCoinServiceHandler: WebserviceHandler {
	weak var delegate: BitCoinServiceDelegate?
	/**
	Request data for today, from coindesk API
	- Parameters:
		- completion: closure to execute when result has been retreived. A BitCoinRecord optional will be passed as argument.
	- Returns: void
	**/
	func requestDataForToday() {
		guard let url = Endpoints.BCcurrentprice.url else { return }
		requestJSON(withURL: url, method: .get) { [weak self] data in
			self?.delegate?.didReceiveTodayBitCoinData(BitCoinRecord.factory(data: data))
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
	func requestHistoryData(_ startDate: Date, endDate: Date, currency: Currency) {
		guard let url = Endpoints.BChistoricalPrice.withQuery(startDate, endDate: endDate, currency: currency.rawValue) else { return }
		requestJSON(withURL: url, method: .get) { [weak self] data in
			self?.delegate?.didReceiveHistoricalBitCoinData(forCurrency: currency, HistoricalBPIRecord.factory(data: data))
		}
	}
}
