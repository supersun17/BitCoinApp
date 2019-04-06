//
//  HistoricalBPIManager.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/6/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

/**
CoinDesk Historical API only returns records for one currency. To retreive all three currencies, you need to call the API three times. The response are not going to arrive at the same time.
Historical BPI Manager takes in CoinDesk data for each currency, merge and convert them into something match our UI. Later you can use the provided api to get certain data.
**/
class HistoricalBPIManager {
	typealias BPIRecord = [Currency:Double]

	/**
	bpiRecordsDict's format looks like this: [yyyy-MM-dd: [EUR:10000.0000] ]
	**/
	private var bpiRecordsDict: [String:BPIRecord] = [:]
	/**
	dateStringArray listed the past two weeks into a descending array, the latest is the first
	**/
	private(set) var dateStringArray: [String] = []

	/**
	Get price for a specific date and currency
	- Parameters:
		- dateString: format "2019-03-23"
	- Returns: optional price in Double. If data for a specific currency is not ready, return nil
	**/
	func getPrice(forDate dateString: String, currency: Currency) -> Double? {
		if let record = bpiRecordsDict[dateString], let price = record[currency] {
			return price
		} else {
			return nil
		}
	}

	/**
	Get price for a specific date and currency
	- Parameters:
		- date: Swift Date
	- Returns: price in Double. If data for a specific currency is not ready, return nil
	**/
	func getPrice(forDate date: Date, currency: Currency) -> Double? {
		let dateString = DateConvertor().dateToUTCString(date)
		if let record = bpiRecordsDict[dateString], let price = record[currency] {
			return price
		} else {
			return nil
		}
	}

	/**
	Pass the currency and historical BPI data from coindesk into this function. Let this manager merge and prepare them for display.
	- Parameters:
		- currency: currency for this data
		- record: the mapped bpi data from coindesk
	- Returns: -
	**/
	func addBPIData(forCurrency currency: Currency, hitoricalBPIRecord record: HistoricalBPIRecord) {
		guard let priceDict = record.bpi else { return }

		if dateStringArray.count == 0 {
			dateStringArray = priceDict.keys.sorted { $0 > $1 }
		}

		for dateString in dateStringArray {
			if let price = priceDict[dateString] {
				if bpiRecordsDict[dateString] != nil {
					bpiRecordsDict[dateString]![currency] = price
				} else {
					bpiRecordsDict[dateString] = [currency:price]
				}
			}
		}
	}
}
