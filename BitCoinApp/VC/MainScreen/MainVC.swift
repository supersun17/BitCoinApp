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

	var realTimeCoordinator: RealTimeCoordinator! // For 60s cycle and 10 cycle data / UI update control
	var serviceHandler: BitCoinServiceHandler! // For CoinDesk API service
	var historicalBPIManager: HistoricalBPIManager! // For multi-currency BPI data merging/retrieving control

	let allCurrencies = [Currency.USD, Currency.EUR, Currency.GBP]
	var mainCurrency: Currency = .USD // The default Currency mentioned as project requirement

	var currentBitCoinRecord: BitCoinRecord? // Today's current BitCoin data from Coindesk
	var priceState: Bool = true


	override func loadView() {
		Bundle.main.loadNibNamed("MainView", owner: self, options: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		navigationItem.title = "BitCoinApp"

		historicalBPIManager = HistoricalBPIManager()
		setupServiceHandler()
		setupRealTimeCoordinator()
		setupTableView()

		requestHistoricalBitCoinData()
	}

	func setupServiceHandler() {
		serviceHandler = BitCoinServiceHandler()
		serviceHandler.delegate = self
	}

	// Configure RealTimeCoordinator, and start ticking immediately
	func setupRealTimeCoordinator() {
		realTimeCoordinator = RealTimeCoordinator.init(apiRequestInterval: TimingConstants.BCAPIRequestInterval,
													   displayRefreshInterval: TimingConstants.BCDisplayRefreshInterval)
		realTimeCoordinator.startDataUpdate(with: self)
		realTimeCoordinator.startDisplayUpdate(with: self)
	}

	func setupTableView() {
		historyTableView.delegate = self
		historyTableView.dataSource = self
	}

	/**
	Call it to request Today's BitCoin data.
	To receive callback, this VC must conform to BitCoinServiceDelegate
	- Parameters: -
	- Returns: -
	**/
	func requestTodayBitCoinData() {
		serviceHandler.requestDataForToday()
	}

	/**
	Call it to request Historical BitCoin data.
	To receive callback, this VC must conform to BitCoinServiceDelegate
	- Parameters: -
	- Returns: -
	**/
	func requestHistoricalBitCoinData() {
		let today = QuickDate.Today.create()
		let twoWeekAgo = QuickDate.TwoWeeksAgo.create()
		for c in allCurrencies {
			serviceHandler.requestHistoryData(twoWeekAgo, endDate: today, currency: c)
		}
	}

	/**
	Call it to update TodayView with the updated BitCoin data.
	- Parameters: -
	- Returns: -
	**/
	func updateTodayViewDisplay() {
		guard
			let record = currentBitCoinRecord,
			let symbol = record.usdDetails?.symbol?.decoded,
			let price = record.usdDetails?.rateFloat
			else {
				return
		}
		todayView.updateBCPrice(symbol: symbol, price: price, priceState: priceState)
	}
}

extension MainVC: BitCoinServiceDelegate {
	func didReceiveTodayBitCoinData(_ record: BitCoinRecord?) {
		let oldPrice = currentBitCoinRecord?.usdDetails?.rateFloat ?? 0.0
		let newPrice = record?.usdDetails?.rateFloat ?? 0.0
		currentBitCoinRecord = record
		priceState = (newPrice >= oldPrice)
		_ = executeOnce
	}

	/// - Note: The VC will post a notification when it's done data processing. Anyone who's observing the notification will have a chance to update it's data to the newest one.
	func didReceiveHistoricalBitCoinData(forCurrency currency: Currency, _ record: HistoricalBPIRecord?) {
		if let record = record {
			/// - Note: main queue is a serial queue, writing data on this queue raise cause multi-threading concern
			historicalBPIManager.addBPIData(forCurrency: currency, hitoricalBPIRecord: record)
			/// - Note: MainVC historical tableView only shows EUR
			historyTableView.reloadData()
		}
	}

	func didReceiveError(_ error: Error) {
		print(error.localizedDescription)
	}
}

