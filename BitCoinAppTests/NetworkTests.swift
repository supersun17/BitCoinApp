//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import XCTest
@testable import BitCoinApp

class NetworkTests: XCTestCase {
	var bitCoinServiceHandler: BitCoinServiceHandler!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()

		bitCoinServiceHandler = BitCoinServiceHandler()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testTodayRequest() {
		let exp = expectation(description: "requestDataForToday started")
		bitCoinServiceHandler!.requestDataForToday { (record) in
			XCTAssertNotNil(record)
			XCTAssertNotNil(record?.usdDetails?.rateFloat)
			XCTAssertNotNil(record?.eurDetails?.rateFloat)
			XCTAssertNotNil(record?.gbpDetails?.rateFloat)
			exp.fulfill()
		}
		waitForExpectations(timeout: 3) { error in
			if let error = error {
				XCTFail("requestDataForToday timeout. error: \(error)")
			}
		}
	}

	func testHistoryRequest() {
		let today = Date()
		let twoWeekAgo = Date.init(timeInterval: -3600 * 24 * 14, since: today)
		let exp = expectation(description: "requestHistoryData started")
		bitCoinServiceHandler!.requestHistoryData(twoWeekAgo, endDate: today, currency: "EUR") { (historicalBPIRecord) in
			XCTAssertNotNil(historicalBPIRecord)
			XCTAssertNotNil(historicalBPIRecord?.bpi)
			exp.fulfill()
		}
		waitForExpectations(timeout: 3) { error in
			if let error = error {
				XCTFail("requestHistoryData timeout. error: \(error)")
			}
		}
	}
}
