//
//  BitCoinRecord.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation
import ObjectMapper

/**
{
	"time":{
		"updated":"Sep 18, 2013 17:27:00 UTC",
		"updatedISO":"2013-09-18T17:27:00+00:00"
	},
	"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index. Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
	"bpi":{
		"USD":{
			"code":"USD",
			"symbol":"$",
			"rate":"126.5235",
			"description":"United States Dollar",
			"rate_float":126.5235
		},
		"GBP":{
			"code":"GBP",
			"symbol":"£",
			"rate":"79.2495",
			"description":"British Pound Sterling",
			"rate_float":79.2495
		},
		"EUR":{
			"code":"EUR",
			"symbol":"€",
			"rate":"94.7398",
			"description":"Euro",
			"rate_float":94.7398
		}
	}
}
**/

struct BitCoinRecord: Mappable {
	var updatedAt: String?
	var usdDetails: PriceDetails?
	var gbpDetails: PriceDetails?
	var eurDetails: PriceDetails?

	init?(map: Map) {}

	mutating func mapping(map: Map) {
		updatedAt <- map["time.updated"]
		usdDetails <- map["bpi.USD"]
		gbpDetails <- map["bpi.GBP"]
		eurDetails <- map["bpi.EUR"]
	}

	static func factory(data: Any?) -> BitCoinRecord? {
		if let record = Mapper<BitCoinRecord>().map(JSONObject: data) {
			return record
		} else {
			return nil
		}
	}

	static func factoryToArray(data: Any?) -> [BitCoinRecord] {
		if let recordsArray = Mapper<BitCoinRecord>().mapArray(JSONObject: data) {
			return recordsArray
		} else {
			return []
		}
	}
}

struct PriceDetails: Mappable {
	var code: String?
	var symbol: String?
	var rate: Double?
	var description: String?
	var rateFloat: Double?

	init?(map: Map) {}

	mutating func mapping(map: Map) {
		code <- map["code"]
		symbol <- map["symbol"]
		rate <- map["rate"]
		description <- map["description"]
		rateFloat <- map["rate_float"]
	}
}

