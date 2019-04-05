//
//  RootVC.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/5/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import UIKit

/**
Handles the view stack setup. setupAndReturnRootVC() will return a control stack like this:
NavigationVC -> {MainVC}
Other VC and later be pushed into the stack
**/
class RootVC {
	func setupAndReturnRootVC() -> UINavigationController {
		let navVC = UINavigationController()
		let mainVC = MainVC()
		navVC.viewControllers = [mainVC]
		return navVC
	}
}
