//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import XCTest
@testable import BitCoinApp

class NetworkTests: XCTestCase, BitCoinServiceDelegate {
	var bitCoinServiceHandler: BitCoinServiceHandler!
	var todayRequestExp: XCTestExpectation!
	var historyRequestExp: XCTestExpectation!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()

		bitCoinServiceHandler = BitCoinServiceHandler()
		bitCoinServiceHandler.delegate = self
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testTodayRequest() {
		todayRequestExp = expectation(description: "requestDataForToday started")
		bitCoinServiceHandler!.requestDataForToday ()
		waitForExpectations(timeout: 3) { error in
			if let error = error {
				XCTFail("requestDataForToday timeout. error: \(error)")
			}
		}
	}

	func didReceiveTodayBitCoinData(_ record: BitCoinRecord?) {
		XCTAssertNotNil(record)
		XCTAssertNotNil(record?.usdDetails?.rateFloat)
		XCTAssertNotNil(record?.eurDetails?.rateFloat)
		XCTAssertNotNil(record?.gbpDetails?.rateFloat)
		todayRequestExp.fulfill()
	}

	func testHistoryRequest() {
		let today = QuickDate.Today.create()
		let twoWeekAgo = QuickDate.TwoWeeksAgo.create()
		historyRequestExp = expectation(description: "requestHistoryData started")
		bitCoinServiceHandler!.requestHistoryData(twoWeekAgo, endDate: today, currency: Currency.EUR)
		waitForExpectations(timeout: 3) { error in
			if let error = error {
				XCTFail("requestHistoryData timeout. error: \(error)")
			}
		}
	}

	func didReceiveHistoricalBitCoinData(forCurrency: Currency, _ record: HistoricalBPIRecord?) {
		XCTAssertNotNil(record)
		XCTAssertNotNil(record?.bpi)
		historyRequestExp.fulfill()
	}

	func didReceiveError(_ error: Error) {}
}
