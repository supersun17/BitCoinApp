//
//  RealTimeCoordinator.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

class RealTimeCoordinator {
	private let apiRequestInterval: TimeInterval
	private var apiRequestTimer: Timer!

	private let displayRefreshInterval: TimeInterval
	private var displayRefreshTimer: Timer!

	weak var dataProvider: RealTimeCoordinatorDataProvider?
	weak var dataDisplayer: RealTimeCoordinatorDataDisplayer?

	init(apiRequestInterval: TimeInterval, displayRefreshInterval: TimeInterval) {
		self.apiRequestInterval = apiRequestInterval
		self.displayRefreshInterval = displayRefreshInterval
	}

	func startDataUpdate(with dataProvider: RealTimeCoordinatorDataProvider) {
		self.dataProvider = dataProvider
		apiRequestTimer = Timer.scheduledTimer(timeInterval: apiRequestInterval, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
		apiRequestTimer.fire()
	}

	func startDisplayUpdate(with dataDisplayer: RealTimeCoordinatorDataDisplayer) {
		self.dataDisplayer = dataDisplayer
		displayRefreshTimer = Timer.scheduledTimer(timeInterval: displayRefreshInterval, target: self, selector: #selector(updateDisplay), userInfo: nil, repeats: true)
		displayRefreshTimer.fire()
	}

	@objc func updateData() {
		dataProvider?.updateData()
	}

	@objc func updateDisplay() {
		dataDisplayer?.updateDisplay()
	}

	deinit {
		apiRequestTimer.invalidate()
		displayRefreshTimer.invalidate()
	}
}
