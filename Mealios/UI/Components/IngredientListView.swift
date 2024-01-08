//
//  IngredientListView.swift
//  Mealios
//
//  Created by Daniel Ries on 9/9/23.
//

import SwiftUI

struct IngredientListView: View {
	var ingredient: RecipeIngredient

	// Ingredient quantity comes in as a double. Change to int if no fractional details
	func ingredientQuantityConversion() -> String {
		guard let quantity = ingredient.quantity else {
			return ""
		}
		let isInteger = (quantity == floor(quantity))
		return isInteger ? Int(quantity).description : quantity.description
	}

	var body: some View {
		VStack(alignment: .leading) {
			if ingredient.title != nil && !ingredient.title!.isEmpty {
				Text(ingredient.title!)
					.font(.custom(Fonts().robotoBold, size: 15))
				Divider()
					.overlay(Color("CardColor"))
			}
			Text(ingredient.display)
				.font(.custom(Fonts().robotoRegular, size: 15))
		}
	}
}

struct IngredientListView_Previews: PreviewProvider {
	static var previews: some View {
		IngredientListView(ingredient:
			RecipeIngredient(
				quantity: 2, unit:
				IngredientUnit(name: "tbsp",
				               pluralName: "tbsp",
				               description: "",
				               fraction: true,
				               abbreviation: "tbsp",
				               pluralAbbreviation: "",
				               useAbbreviation: true, id: "",
				               aliases: [],
				               createdAt: "", updateAt: ""),
				food: IngredientFood(name: "honey",
				                     pluralName: "",
				                     description: "",
				                     labelId: "",
				                     aliases: [],
				                     id: "", label:
				                     MultiPurposeLabelSummary(name: "",
				                                              color: "",
				                                              groupId: "",
				                                              id: ""),
				                     createdAt: "",
				                     updateAt: ""),
				note: "",
				isFood: true,
				disableAmount: false,
				display: "",
				title: "",
				originalText: "",
				referenceId: ""
			))
	}
}
