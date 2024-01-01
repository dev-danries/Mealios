//
//  AppSettings.swift
//  Mealios
//
//  Created by Daniel Ries on 7/28/23.
//

import Foil
import Foundation

final class AppSettings: NSObject, ObservableObject {
	static let shared = AppSettings()

	@WrappedDefault(key: "isSetup")
	@objc dynamic var isSetup = false {
		willSet {
			objectWillChange.send()
		}
	}

	@WrappedDefault(key: "mealieServerUrl")
	var serverUrl: String = ""

	@WrappedDefault(key: "mealieApiToken")
	var apiToken: String = ""

	@WrappedDefault(key: "mealieApiTokenId")
	var apiTokenId: Int = -1
}
