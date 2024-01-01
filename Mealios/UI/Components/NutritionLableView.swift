//
//  NutritionLableView.swift
//  Mealios
//
//  Created by Daniel Ries on 9/10/23.
//

import SwiftUI

struct NutritionLabelView: View {
	var nutrition: RecipeNutrition

	var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			Text("Nutrition Facts")
				.font(.custom(Fonts().robotoExtraBold, size: 24))
				.lineLimit(1)
			Divider()
			HStack {
				Text("Calories")
					.font(.custom(Fonts().robotoExtraBold, size: 18))
					.bold()
				Spacer()
				Text(nutrition.calories!)
					.font(.custom(Fonts().robotoRegular, size: 18))
			}
			Divider()
			HStack {
				Text("Total Fat")
					.font(.custom(Fonts().robotoExtraBold, size: 18))
					.bold()
				Spacer()
				Text("\(nutrition.fatContent!) g")
					.font(.custom(Fonts().robotoRegular, size: 18))
			}
			Divider()
			HStack {
				Text("Sodium")
					.font(.custom(Fonts().robotoExtraBold, size: 18))
					.bold()
				Spacer()
				Text("\(nutrition.sodiumContent!) mg")
					.font(.custom(Fonts().robotoRegular, size: 18))
			}
			Divider()
			HStack {
				Text("Protein")
					.font(.custom(Fonts().robotoExtraBold, size: 18))
					.bold()
				Spacer()
				Text("\(nutrition.proteinContent!) g")
					.font(.custom(Fonts().robotoRegular, size: 18))
			}
			Divider()
			HStack {
				Text("Total Carbs")
					.font(.custom(Fonts().robotoExtraBold, size: 18))
					.bold()
				Spacer()
				Text("\(nutrition.carbohydrateContent!) g")
					.font(.custom(Fonts().robotoRegular, size: 18))
			}
		}
		.padding(10)
	}
}

struct NutritionLabelView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(ColorScheme.allCases, id: \.self, content:
			NutritionLabelView(nutrition:
				RecipeNutrition(calories: Optional("230"),
				                fatContent: Optional("8"),
				                proteinContent: Optional("3"),
				                carbohydrateContent: Optional("37"),
				                fiberContent: Optional("4"),
				                sodiumContent: Optional("160"),
				                sugarContent: Optional("1"))).preferredColorScheme)
	}
}
