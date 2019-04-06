//
//  MainVC+RealtimeCoordinator.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/6/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation


/**
MainVC is the data provider, and data displayer of the BitCoin data.
**/
extension MainVC: RealTimeCoordinatorDataProvider, RealTimeCoordinatorDataDisplayer {
	func updateData() {
		requestTodayBitCoinData()
	}

	func updateDisplay() {
		updateTodayViewDisplay()
	}
}
