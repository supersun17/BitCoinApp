//
//  MainVC.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
	@IBOutlet weak var todayView: TodayView!
	@IBOutlet weak var historyTableView: UITableView!

	/**
	This variable is used to triger the first time TodayView display update.
	This is because the first time API response comes in after the first time UI update. There will be 8 - 9 seconds wait time till the next UI update cycle. Thus the UI update has to be execute once here.
	**/
	lazy var executeOnce: Int = { [weak self] in
		self?.updateDisplay()
		return 0
	}()

	var realTimeCoordinator: RealTimeCoordinator!

	var serviceHandler: BitCoinServiceHandler!

	var currency: Currency = .EUR
	var currentBitCoinRecord: BitCoinRecord?
	var historicalBPIRecord: HistoricalBPIRecord? {
		didSet {
			guard let priceDict = historicalBPIRecord?.bpi else { return }
			sortedDateStringArray = priceDict.keys.sorted { $0 > $1 }
		}
	}
	var sortedDateStringArray: [String] = []

	override func loadView() {
		Bundle.main.loadNibNamed("MainView", owner: self, options: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		navigationItem.title = "BitCoinApp"
		setupServiceHandler()
		setupRealTimeCoorninator()
		setupTableView()
	}

	func setupServiceHandler() {
		serviceHandler = BitCoinServiceHandler()
		serviceHandler.delegate = self
	}

	func requestTodayBitCoinData() {
		serviceHandler.requestDataForToday()
	}

	func updateTodayViewDisplay() {
		guard
			let record = currentBitCoinRecord,
			let symbol = record.eurDetails?.symbol,
			let price = record.eurDetails?.rateFloat
			else {
				return
		}
		todayView.updateBCPrice(symbol: symbol, price: price)
	}

	func requestHistoricalBitCoinData() {
		let today = QuickDate.Today.create()
		let twoWeekAgo = QuickDate.TwoWeeksAgo.create()
		serviceHandler.requestHistoryData(twoWeekAgo, endDate: today, currency: currency.rawValue)
	}
}

extension MainVC: BitCoinServiceDelegate {
	func didReceiveTodayBitCoinData(_ record: BitCoinRecord?) {
		currentBitCoinRecord = record
		_ = executeOnce
	}

	func didReceiveHistoricalBitCoinData(_ record: HistoricalBPIRecord?) {
		historicalBPIRecord = record
		historyTableView.reloadData()
	}
}

