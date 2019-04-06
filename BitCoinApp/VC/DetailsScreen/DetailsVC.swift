//
//  DetailsVC.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/6/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

/**
Display EUR, USD, GBP prices for a specific date.
**/
class DetailsVC: UIViewController {
	@IBOutlet weak var labelEUR: UILabel!
	@IBOutlet weak var labelUSD: UILabel!
	@IBOutlet weak var labelGBP: UILabel!

	var featuringDateString: String!
	weak var historicalBPIManager: HistoricalBPIManager!

	override func loadView() {
		Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = featuringDateString
		/// - Note: Observe notification from HistoricalBPIManager. This is because some times not all of the currencies are ready. Once updated, this VC should check the most updated data again.
		NotificationCenter.default.addObserver(self,
											   selector: #selector(dataUpdated),
											   name: CustomNotificationName.BPIDidUpdate,
											   object: nil)
		setLabels()
	}

	func setLabels() {
		if let price = historicalBPIManager.getPrice(forDate: featuringDateString, currency: .EUR) {
			labelEUR.text = "EUR \(Currency.EUR.symbol)\(price)"
		}
		if let price = historicalBPIManager.getPrice(forDate: featuringDateString, currency: .USD) {
			labelUSD.text = "USD \(Currency.USD.symbol)\(price)"
		}
		if let price = historicalBPIManager.getPrice(forDate: featuringDateString, currency: .GBP) {
			labelGBP.text = "GBP \(Currency.GBP.symbol)\(price)"
		}
	}

	@objc func dataUpdated() {
		setLabels()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		NotificationCenter.default.removeObserver(self)
	}
}
