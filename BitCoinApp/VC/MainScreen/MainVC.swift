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

	var currentBitCoinRecord: BitCoinRecord?

	override func loadView() {
		Bundle.main.loadNibNamed("MainView", owner: self, options: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		serviceHandler = BitCoinServiceHandler()
		setupRealTimeCoorninator()
	}
}

/**
MainVC is the data provider, and data displayer of the BitCoin data. This is a MVC architecture App.
**/
extension MainVC: RealTimeCoordinatorDataProvider, RealTimeCoordinatorDataDisplayer {
	func setupRealTimeCoorninator() {
		realTimeCoordinator = RealTimeCoordinator.init(apiRequestInterval: TimingConstants.BCAPIRequestInterval,
													   displayRefreshInterval: TimingConstants.BCDisplayRefreshInterval)
		realTimeCoordinator.startDataUpdate(with: self)
		realTimeCoordinator.startDisplayUpdate(with: self)
	}

	func updateData() {
		serviceHandler.requestDataForToday { [weak self] (record) in
			self?.currentBitCoinRecord = record
			_ = self?.executeOnce
		}
	}

	func updateDisplay() {
		guard
			let record = currentBitCoinRecord,
			let symbol = record.eurDetails?.symbol,
			let price = record.eurDetails?.rateFloat
			else {
				return
		}
		todayView.updateBCPrice(symbol: symbol, price: price)
	}
}

