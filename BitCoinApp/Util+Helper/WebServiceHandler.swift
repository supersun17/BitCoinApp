//
//  WebServiceHandler.swift
//  BitCoinApp
//
//  Created by Ming Sun on 4/4/19.
//  Copyright © 2019 Ming Sun. All rights reserved.
//

import Foundation
import Alamofire

class WebserviceHandler {
	func requestJSON(withURL url: URL, method: HTTPMethod, completion: @escaping (_ data: Any?, _ error: Error?) -> Void) {
		Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
			switch response.result {
			case .success(let data):
				completion(data, nil)
				break
			case .failure(let error):
				completion(nil, error)
				break
			}
		}
	}
}
