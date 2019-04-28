//
//  TodayView.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

/**
Display Today's BitCoin price info.
Call updateBCPrice(symbol:, price:) to update its display
**/
class TodayView: UIView {
	@IBOutlet var contentView: UIView!
	@IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var labelCurrentPrice: UILabel!
	@IBOutlet weak var labelLastUpdatedAt: UILabel!

	let heartbeatPosColor = UIColor.init(red: 0.2941, green: 0.8274, blue: 0.1490, alpha: 1.0)
	let heartbeatNegColor = UIColor.init(red: 0.9686, green: 0.2901, blue: 0.2392, alpha: 1.0)
	let normalColor = UIColor.init(red: 0.9686, green: 0.2901, blue: 0.2392, alpha: 0.0)

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

	/**
	Update diplay to the designated value. And the time stamp on the bottom-right corner will be updated automatically according to the udpate time.
	- Parameters:
		- symbol: can be "EUR", or "&EURO;"
		- price: the price value in Double
	- Returns: void
	**/
	func updateBCPrice(symbol: String, price: Double, priceState: Bool) {
		labelCurrentPrice.text = "\(symbol)\(price.twoDigitsAccuracyString)"
		labelLastUpdatedAt.text = "Updated at " + DateConvertor().dateToAMPMTimeString(Date())
		let animator = CABasicAnimation.init(keyPath: "backgroundColor")
		animator.fromValue = (priceState) ? (heartbeatPosColor.cgColor):(heartbeatNegColor.cgColor)
		animator.toValue = normalColor.cgColor
		animator.duration = TimingConstants.TodayViewHeartBeatInterval
		contentView.layer.add(animator, forKey: "heartbeat")
	}
}
