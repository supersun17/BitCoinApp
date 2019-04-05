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

