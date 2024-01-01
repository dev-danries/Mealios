//
//  RequestModels.swift
//  Mealios
//
//  Created by Daniel Ries on 7/29/23.
//

import Foundation

// MARK: - Authentication

struct UserTokenRequest: Codable {
	var username: String
	var password: String
	var grantType: String = "password"

	func getAsURLEncodedFormParams() -> [String: String] {
		return [
			"username": username,
			"password": password,
			"grant_type": grantType,
		]
	}

	enum CodingKeys: String, CodingKey {
		case grantType = "grant_type"
		case username
		case password
	}
}

struct APITokenRequest: Codable {
	var name: String
}
