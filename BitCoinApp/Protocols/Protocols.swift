//
//  Protocols.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation

protocol RealTimeCoordinatorDataProvider: class {
	func updateData()
}

protocol RealTimeCoordinatorDataDisplayer: class {
	func updateDisplay()
}

protocol BitCoinServiceDelegate: class  {
	func didReceiveTodayBitCoinData(_ record: BitCoinRecord?)
	func didReceiveHistoricalBitCoinData(forCurrency: Currency, _ record: HistoricalBPIRecord?)
	func didReceiveError(_ error: Error)
}
