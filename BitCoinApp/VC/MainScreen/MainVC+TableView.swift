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
		var cell = tableView.dequeueReusableCell(withIdentifier: "OtherDayCell")
		if cell == nil {
			cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "OtherDayCell")
		}

		cell!.selectionStyle = .none
		return cell!
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let dateString = historicalBPIManager.dateStringArray[indexPath.row]
		let textArray = allCurrencies.map { getDisplayText(forDate: dateString, currency: $0) }
		cell.textLabel?.text = textArray.joined(separator: "\t")
		cell.detailTextLabel?.text = "\(dateString)"
	}

	func getDisplayText(forDate dateString: String, currency: Currency) -> String {
		let price = historicalBPIManager.getPrice(forDate: dateString, currency: currency)
		let priceString = (price == nil) ? ("loading"):(price!.twoDigitsAccuracyString)
		return currency.symbol + ":" + priceString
	}
}
