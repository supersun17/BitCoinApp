//
//  MainVC+TableView.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

/**
MainVC is the delegate and datasource of the tableView.
**/
extension MainVC: UITableViewDelegate, UITableViewDataSource {
	func setupTableView() {
		historyTableView.delegate = self
		historyTableView.dataSource = self
		requestHistoricalBitCoinData()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sortedDateStringArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "OtherDayCell")
		return cell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let dateString = sortedDateStringArray[indexPath.row]
		guard
			let priceDict = historicalBPIRecord?.bpi,
			let price = priceDict[dateString]
			else {
				return
		}
		cell.textLabel?.text = "\(currency.symbol)\(price)"
		cell.detailTextLabel?.text = "\(dateString)"
	}
}
