//
//  HistoricalBPIRecord.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation
import ObjectMapper

/**
{
	"bpi":{
		"2013-09-01":128.2597,
		"2013-09-02":127.3648,
		"2013-09-03":127.5915,
		"2013-09-04":120.5738,
		"2013-09-05":120.5333
	},
	"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index. BPI value data returned as USD.",
	"time":{
		"updated":"Sep 6, 2013 00:03:00 UTC",
		"updatedISO":"2013-09-06T00:03:00+00:00"
	}
}
**/
struct HistoricalBPIRecord: Mappable {
	var bpi: [String:Double]?
	var updatedAt: String?

	init?(map: Map) {}

	mutating func mapping(map: Map) {
		bpi <- map["bpi"]
		updatedAt <- map["time.updated"]
	}

	static func factory(data: Any?) -> HistoricalBPIRecord? {
		if let bpiRecord = Mapper<HistoricalBPIRecord>().map(JSONObject: data) {
			return bpiRecord
		} else {
			return nil
		}
	}
}
