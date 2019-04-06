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
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return historicalBPIManager.dateStringArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "OtherDayCell")
		cell.selectionStyle = .none
		return cell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let dateString = historicalBPIManager.dateStringArray[indexPath.row]
		guard let price = historicalBPIManager.getPrice(forDate: dateString, currency: mainCurrency) else {
			return
		}
		cell.textLabel?.text = "\(mainCurrency.symbol)\(price)"
		cell.detailTextLabel?.text = "\(dateString)"
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let dateString = historicalBPIManager.dateStringArray[indexPath.row]
		pushDetailsScreen(for: dateString)
	}
}
