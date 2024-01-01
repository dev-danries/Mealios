//
//  IntExtensions.swift
//  Mealios
//
//  Created by Daniel Ries on 9/9/23.
//

import Foundation

extension Int {
	static func parse(from string: String) -> Int? {
		Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
	}
}
