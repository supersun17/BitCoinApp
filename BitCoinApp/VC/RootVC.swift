//
//  RootVC.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

class RootVC {
	func setupAndReturnRootVC() -> UINavigationController {
		let navVC = UINavigationController()
		let mainVC = MainVC()
		navVC.viewControllers = [mainVC]
		return navVC
	}
}
