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
	static func request(withURL url: URL, method: HTTPMethod, completion: @escaping (_ data: Any?) -> Void) {
		Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
			switch response.result {
			case .success(let data):
				completion(data)
				break
			case .failure(let error):
				print(error)
				completion(nil)
				break
			}
		}
	}
}
