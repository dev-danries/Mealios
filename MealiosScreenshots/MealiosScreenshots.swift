//
//  MealiosScreenshots.swift
//  MealiosScreenshots
//
//  Created by Daniel Ries on 7/28/23.
//

import XCTest

final class MealiosScreenshots: XCTestCase {
	var app: XCUIApplication!
	let device = XCUIDevice.shared

	let demoUrl = "https://demo.mealie.io"
	let demoLoginEmail = "changeme@example.com"
	let demoLoginPassword = "MyPassword"

	@MainActor override func setUpWithError() throws {
		app = XCUIApplication()
		setupSnapshot(app)
		app.launch()
		continueAfterFailure = false
		device.orientation = .portrait
	}

	override func tearDownWithError() throws {
		app.terminate()
	}

	@MainActor func test_LaunchScreenshot() async throws {
		snapshot("Launch")
	}

	@MainActor func test_homepageScreenshot() async throws {
		let serverUrlTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "serverUrl")
		let emailTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "mealieEmail")
		let passwordTextField = app.secureTextFields.element(matching: XCUIElement.ElementType.secureTextField, identifier: "mealiePassword")
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")

		tapAndType(serverUrlTextField, text: demoUrl)
		tapAndType(emailTextField, text: demoLoginEmail)
		tapAndType(passwordTextField, text: demoLoginPassword)

		continueButton.tap()

		sleep(20)

		snapshot("Home View")
	}

	func tapAndType(_ element: XCUIElement, text: String) {
		element.tap()
		element.typeText(text)
	}
}
