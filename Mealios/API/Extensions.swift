//
//  Extensions.swift
//  Mealios
//
//  Created by Daniel Ries on 1/7/24.
//

import Alamofire
import Foundation

public extension Request {
	func log() -> Self {
		#if DEBUG
			debugPrint(self)
		#endif
		return self
	}
}
