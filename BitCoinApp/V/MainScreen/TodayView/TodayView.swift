//
//  TodayView.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

class TodayView: UIView {
	@IBOutlet var contentView: UIView!
	@IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var labelCurrentPrice: UILabel!
	@IBOutlet weak var labelLastUpdatedAt: UILabel!

	private func customInit() {
		Bundle.main.loadNibNamed("TodayView", owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = bounds
		contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		customInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		customInit()
	}

	func updateBCPrice(symbol: String, price: Double) {
		guard let decodedSymbol = symbol.decoded else {
			print("nil symbol found at \(#file),\(#function)")
			return
		}
		labelCurrentPrice.text = "\(decodedSymbol)\(price)"
		labelLastUpdatedAt.text = "Updated at: " + DateConvertor().dateToAMPMTimeString(Date())
	}
}
