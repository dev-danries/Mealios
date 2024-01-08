//
//  UITestExtensions.swift
//  Mealios
//
//  Created by Daniel Ries on 1/1/24.
//

import XCTest

// MARK: - Foil Details

extension XCUIApplication {
	func setIsSetup(_ isSetup: Bool = false) {
		launchArguments += ["-isSetup", isSetup ? "true" : "false"]
	}

	func setMealieServerUrl(_ serverUrl: String = "") {
		launchArguments += ["-mealieServerUrl", serverUrl]
	}

	func setMealieApiToken(_ apiToken: String = "") {
		launchArguments += ["-mealieApiToken", apiToken]
	}

	func setMealieApiTokenId(_ apiTokenId: Int = -1) {
		launchArguments += ["-mealieApiTokenId", String(apiTokenId)]
	}

	func setAllUserDefaultsToNewInstall() {
		setIsSetup()
		setMealieServerUrl()
		setMealieApiToken()
		setMealieApiTokenId()
	}
}

extension XCUIElement {
	func tapAndType(text: String) {
		tap()
		typeText(text)
	}
}
