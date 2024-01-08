//
//  SetupViewUITests.swift
//  MealiosUITests
//
//  Created by Daniel Ries on 7/28/23.
//

import Telegraph
import XCTest

final class SetupViewUITests: XCTestCase {
	var app: XCUIApplication!
	let device = XCUIDevice.shared

	let demoUrl = "http://localhost:9000"
	let demoLoginEmail = "changeme@example.com"
	let demoLoginPassword = "MyPassword"

	// Runs Once
	override class func setUp() {
		let server = Server()
		try! server.start(port: 9000, interface: "localhost")

		server.route(.POST, "/api/auth/token") { (.ok, "{\"token\":\"testToken\",\"type\":\"bearer\"}") }
		server.route(.POST, "/api/users/api-tokens") { (.ok, "{\"token\":\"testAPIToken\",\"name\":\"token\",\"id\":\"1\"}") }
	}

	// Runs Before Every Test
	override func setUpWithError() throws {
		app = XCUIApplication()
		continueAfterFailure = false
		app.launch()
		app.setAllUserDefaultsToNewInstall()
	}

	// Runs After Every Test
	override func tearDownWithError() throws {
		app.terminate()
	}

	func testAllElementsAccessible() {
		let serverUrlTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "serverUrl")
		let emailTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "mealieEmail")
		let passwordTextField = app.secureTextFields.element(matching: XCUIElement.ElementType.secureTextField, identifier: "mealiePassword")
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")

		XCTAssert(serverUrlTextField.exists)
		XCTAssert(emailTextField.exists)
		XCTAssert(passwordTextField.exists)
		XCTAssert(continueButton.exists)
	}

	func testSetupView_URLError() {
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")

		continueButton.tap()

		let error = app.staticTexts["Please enter a valid url"]

		XCTAssert(error.exists)
	}

	func testSetupView_EmailError() {
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")
		let serverUrlTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "serverUrl")

		serverUrlTextField.tapAndType(text: demoUrl)

		continueButton.tap()

		let error = app.staticTexts["Please enter email or password"]

		XCTAssert(error.exists)
	}

	func testSetupView_PasswordError() {
		let serverUrlTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "serverUrl")
		let emailTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "mealieEmail")
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")

		serverUrlTextField.tapAndType(text: demoUrl)
		emailTextField.tapAndType(text: demoLoginEmail)

		continueButton.tap()

		let error = app.staticTexts["Please enter email or password"]

		XCTAssert(error.exists)
	}

	func testSetupView_Valid() {
		let serverUrlTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "serverUrl")
		let emailTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "mealieEmail")
		let passwordTextField = app.secureTextFields.element(matching: XCUIElement.ElementType.secureTextField, identifier: "mealiePassword")
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")

		serverUrlTextField.tapAndType(text: demoUrl)
		emailTextField.tapAndType(text: demoLoginEmail)
		passwordTextField.tapAndType(text: demoLoginPassword)

		continueButton.tap()
	}
}
