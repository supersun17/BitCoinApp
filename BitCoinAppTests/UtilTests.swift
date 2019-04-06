//
//  UtilTests.swift
//  BitCoinAppTests
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import XCTest
@testable import BitCoinApp

class UtilTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testDateConvertor() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		let date = Date.init(timeIntervalSince1970: 0)
		let convertor = DateConvertor()
		let dateString = convertor.dateToUTCString(date)
		XCTAssertEqual(dateString, "1970-01-01", "\(dateString) is incorrect")

		let calendar = Calendar.init(identifier: .gregorian)
		var components = calendar.dateComponents([.hour, .minute, .second], from: Date())

		let amDate: Date = {
			components.hour = 11
			components.minute = 59
			components.second = 59
			return calendar.date(from: components)!
		}()
		let amDateString = convertor.dateToAMPMTimeString(amDate)

		XCTAssertEqual(amDateString, "11:59:59 AM", "\(amDateString) is incorrect")
		let pmDate: Date = {
			components.hour = 12
			components.minute = 00
			components.second = 00
			return calendar.date(from: components)!
		}()
		let pmDateString = convertor.dateToAMPMTimeString(pmDate)
		XCTAssertEqual(pmDateString, "12:00:00 PM", "\(pmDateString) is incorrect")
	}

	func testPeriodURL() {
		let startDate = Date.init(timeIntervalSince1970: 3600 * 12)
		let endDate = Date.init(timeIntervalSince1970: 3600 * 24 + 1)

		guard let url = Endpoints.BChistoricalPrice.withQuery(startDate, endDate: endDate, currency: "EUR") else {
			print("nil url found at \(#file),\(#function)")
			return
		}
		let correctURL = URL.init(string: "https://api.coindesk.com/v1/bpi/historical/close.json?start=1970-01-01&end=1970-01-02&currency=EUR")!
		XCTAssertEqual(url, correctURL, "\(url) is incorrect")
	}

	func testCurrencySymbol() {
		let encodedSymbol = "&euro;"
		guard let symbol = encodedSymbol.decoded else {
			print("nil symbol found at \(#file),\(#function)")
			return
		}
		XCTAssert(symbol == "€", "\(symbol) is incorrect")

		let nonEncodedSymbol = "€"
		guard let plainSymbol = nonEncodedSymbol.decoded else {
			print("nil symbol found at \(#file),\(#function)")
			return
		}
		XCTAssert(plainSymbol == "€", "\(plainSymbol) is incorrect")
	}
}
