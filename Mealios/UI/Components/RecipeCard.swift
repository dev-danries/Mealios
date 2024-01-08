//
//  RecipeCard.swift
//  Mealios
//
//  Created by Daniel Ries on 7/30/23.
//

import SwiftUI

struct CardModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.cornerRadius(20)
			.shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
	}
}

struct RecipeCard: View {
	let appSettings = AppSettings.shared
	var recipe: Recipe

	var cardText: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(recipe.name)
				.font(.custom(Fonts().robotoBold, size: 18))
				.foregroundColor(.white)
				.lineLimit(2)
				.multilineTextAlignment(.leading)
				.frame(height: 50)
		}
	}

	var body: some View {
		VStack(alignment: .leading) {
			RemoteImage(url: appSettings.serverUrl + APIPaths.recipeImage.replacingOccurrences(of: "${RECIPE_ID}",
			                                                                                   with: recipe.id))
				.scaledToFill()
				.frame(height: 130)
				.clipped()
				.cornerRadius(20)
			cardText
				.padding([.leading, .trailing, .bottom], 10)
		}
		.padding(10)
		.background(Color("CardColor"))
		.modifier(CardModifier())
	}
}

struct RecipeCardPreview: PreviewProvider {
	static var previews: some View {
		let previewUserDefaults: UserDefaults = {
			let d = UserDefaults(suiteName: "preview_user_defaults")! // swiftlint:disable:this identifier_name
			d.set("https://api.api-ninjas.com/v1/randomimage?category=", forKey: "mealieServerUrl")
			d.set("api-key", forKey: "mealieApiToken")
			return d
		}()

		ForEach(ColorScheme.allCases, id: \.self) {
			RecipeCard(recipe: Recipe(
				id: "2", userId: "", groupId: "", name: "Macro-Friendly Sausage Egg & Cheese Breakfast Sandwiches",
				slug: "macro-friendly-sausage-egg-cheese-breakfast-sandwiches",
				image: "235",
				recipeYield: "",
				totalTime: "",
				prepTime: "",
				cookTime: "",
				performTime: "",
				description: "",
				recipeCategory: [],
				tags: [
					RecipeTag(id: "1", name: "Healthy", slug: "healthy"),
					RecipeTag(id: "2", name: "Meal Prep", slug: "meal-prep"),
				],
				rating: 3,
				dateAdded: "2023-07-27",
				dateUpdated: "2023-07-27T15:38:26.957721",
				createdAt: "",
				updateAt: "",
				lastMade: ""
			)).preferredColorScheme($0).previewDisplayName("\($0)")
				.defaultAppStorage(previewUserDefaults)
				.padding()
		}
	}
}
