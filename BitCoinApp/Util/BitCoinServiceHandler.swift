//
//  BitCoinServiceHandler.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

class BitCoinServiceHandler {
	func requestDataForToday(completion: @escaping (_ recoard: BitCoinRecord?) -> Void) {
		guard let url = Endpoints.BCcurrentprice.url else { return }
		WebserviceHandler.request(withURL: url, method: .get) { data in
			completion(BitCoinRecord.factory(data: data))
		}
	}

	func requestHistoryData(_ startDate: Date, endDate: Date, currency: String, completion: @escaping (_ records: HistoricalBPIRecord?) -> Void) {
		guard let url = Endpoints.BChistoricalPrice.withQuery(startDate, endDate: endDate, currency: currency) else { return }
		WebserviceHandler.request(withURL: url, method: .get) { data in
			completion(HistoricalBPIRecord.factory(data: data))
		}
	}
}
