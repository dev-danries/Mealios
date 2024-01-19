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

	@MainActor func test_homepageScreenshot() async throws {
        snapshot("Launch")
        
		let serverUrlTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "serverUrl")
		let emailTextField = app.textFields.element(matching: XCUIElement.ElementType.textField, identifier: "mealieEmail")
		let passwordTextField = app.secureTextFields.element(matching: XCUIElement.ElementType.secureTextField, identifier: "mealiePassword")
		let continueButton = app.buttons.element(matching: XCUIElement.ElementType.button, identifier: "continueButton")

		tapAndType(serverUrlTextField, text: demoUrl)
		tapAndType(emailTextField, text: demoLoginEmail)
		tapAndType(passwordTextField, text: demoLoginPassword)

		continueButton.tap()

		sleep(5)

		snapshot("Home View")
        
        let firstRecipe = app.buttons.matching(
            attribute: \.identifier,
            is: .contains,
            value: "recipe-card-[",
            options: .caseInsensitive)
            .firstMatch
        
        firstRecipe.tap()
        
        snapshot("Recipe Detail View - 1")
        
        let nutrition = app.staticTexts.matching(attribute: \.label, is: .equalTo, value: "Nutrition Facts").firstMatch
        
        nutrition.tap()
                
        snapshot("Recipe Detail View - 2")
                
        let recipeDetailMenu = app.otherElements.matching(attribute: \.identifier, is: .equalTo, value: "recipe-detail-menu").firstMatch
        let backButton = app.buttons.matching(attribute: \.label, is: .equalTo, value: "Back", options: .caseInsensitive).firstMatch
                
        recipeDetailMenu.tap()
        snapshot("Recipe Detail Menu View")
                
        app.windows.firstMatch.tap()
        
        backButton.tap()
        
        let settingsButton = app.buttons.matching(attribute: \.identifier, is: .equalTo, value: "settings-button").firstMatch
        
        settingsButton.tap()
        snapshot("Settings View")
        
        
	}

	func tapAndType(_ element: XCUIElement, text: String) {
		element.tap()
		element.typeText(text)
	}
}
