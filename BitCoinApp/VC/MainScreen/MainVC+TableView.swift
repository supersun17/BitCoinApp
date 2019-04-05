//
//  MainVC+TableView.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
	func setupTableView() {
		historyTableView.delegate = self
		historyTableView.dataSource = self
		let today = Date()
		let twoWeekAgo = Date.init(timeInterval: -3600 * 24 * 14, since: today)
		serviceHandler.requestHistoryData(twoWeekAgo, endDate: today, currency: currency.rawValue) { [weak self] (historicalBPIRecord) in
			self?.historicalBPIRecord = historicalBPIRecord
			self?.historyTableView.reloadData()
		}
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
