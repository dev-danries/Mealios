//
//  IngredientListView.swift
//  Mealios
//
//  Created by Daniel Ries on 9/9/23.
//

import SwiftUI

struct IngredientListView: View {
	var ingredient: RecipeIngredient

	var body: some View {
		VStack(alignment: .leading) {
			if ingredient.disableAmount {
				if !(ingredient.title == nil) {
					Text(ingredient.title!)
						.font(.custom(Fonts().robotoBold, size: 15))
					Divider()
						.overlay(Color("CardColor"))
				}
				Text(ingredient.note)
					.font(.custom(Fonts().robotoRegular, size: 14))
			} else {
				if ingredient.title != nil {
					Text(ingredient.title!)
						.font(.custom(Fonts().robotoBold, size: 15))
					Divider()
				}
				HStack(spacing: 2.5) {
					Text(ingredient.quantity?.description ?? "")
						.font(.custom(Fonts().robotoRegular, size: 15))
					Text(ingredient.unit?.name ?? "")
						.font(.custom(Fonts().robotoRegular, size: 15))
					Text(ingredient.food.name)
						.font(.custom(Fonts().robotoBold, size: 15))
					if !ingredient.note.isEmpty {
						Text("(\(ingredient.note))")
							.font(.custom(Fonts().robotoRegular, size: 15))
					}
				}
			}
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
