//
//  RealTimeCoordinator.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

/**
Real time coordinator handles data request and ui update via delegation.
The data request happens every 60 second, the ui update happens every 10 seconds as a requirement of the project.
- Note:
	1. conform to RealTimeCoordinatorDataProvider and RealTimeCoordinatorDataDisplayer to receive task.
	2. call startDataUpdate(with:) for data provider setup and fire the first degation
	3. call startDisplayUpdate(with:) for displayer setup and fire the first degation.
**/
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

	/**
	Start coordinator for data update task delegation. A first task will be fired immediately.
	- Parameters:
		- dataProvider: the conformer of RealTimeCoordinatorDataProvider
	- Returns: void
	**/
	func startDataUpdate(with dataProvider: RealTimeCoordinatorDataProvider) {
		self.dataProvider = dataProvider
		apiRequestTimer = Timer.scheduledTimer(timeInterval: apiRequestInterval, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
		apiRequestTimer.fire()
	}

	/**
	Start coordinator for display update task delegation. A first task will be fired immediately.
	- Parameters:
	- dataProvider: the conformer of RealTimeCoordinatorDataDisplayer
	- Returns: void
	**/
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
