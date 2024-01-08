//
//  RecipeDetailView.swift
//  Mealios
//
//  Created by Daniel Ries on 7/31/23.
//

import Alamofire
import SwiftUI

class RecipeDetailViewModel: ObservableObject {
	@Published var recipe: RecipeDetails?
}

struct RecipeDetailView: View {
	@Environment(\.dismiss) private var dismiss
	let appSettings = AppSettings.shared
	var recipeSlug: String
	var recipeName: String
	@ObservedObject var recipeViewModel = RecipeDetailViewModel()
	@State private var cookingModeAlert = false
	@State private var showCookingMode = false

	func fetchRecipeDetails() {
		let authHeader: HTTPHeaders = [.authorization(bearerToken: appSettings.apiToken)]
		AF.request("\(appSettings.serverUrl)\(APIPaths.getRecipe)/\(recipeSlug)", method: .get, headers: authHeader)
			.validate()
			.responseDecodable(of: RecipeDetails.self) { response in
				switch response.result {
				case let .success(recipeDetails):
					print(recipeDetails)
					recipeViewModel.recipe = recipeDetails
				case let .failure(error):
					print(error)
				}
			}
	}

	private func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int, leftMinutes: Int) {
		return (minutes / 60, minutes % 60)
	}

	private func readyInText(minutes: String) -> some View {
		let parsedMinutes = Int.parse(from: minutes)
		var text = "Ready in "
		let tuple = minutesToHoursAndMinutes(Int(parsedMinutes ?? 0))
		let hourText = tuple.hours > 1 ? "hours" : "hour"
		let minText = tuple.leftMinutes > 1 ? "minutes" : "minute"
		if tuple.hours != 0 {
			text += "\(tuple.hours) \(hourText)"
		}
		if tuple.leftMinutes != 0 {
			if tuple.hours != 0 {
				text += ", "
			}
			text += "\(tuple.leftMinutes) \(minText)"
		}
		return HStack {
			Image(systemName: "clock")
			Text(text)
				.font(.custom(Fonts().robotoBold, size: 18))
		}
	}

	func recipeOverview(recipe: RecipeDetails) -> some View {
		VStack(alignment: .leading) {
			if !recipe.description.isEmpty {
				Text(recipe.description)
					.font(.custom(Fonts().robotoRegular, size: 12))
					.foregroundColor(.white)
			}
			if recipe.rating != nil {
				RatingView(rating: .constant(recipe.rating!))
			}
			RemoteImage(url: appSettings.serverUrl + APIPaths.recipeImage.replacingOccurrences(of: "${RECIPE_ID}", with: recipe.id)) // swiftlint:disable:this line_length
				.scaledToFill()
				.frame(height: 130)
				.clipped()
				.cornerRadius(20)
			if !(recipe.totalTime == nil) {
				readyInText(minutes: recipe.totalTime!)
			}
		}
	}

	func ingredientsList(ingredients: [RecipeIngredient], yield: String?) -> some View {
		VStack(alignment: .leading, spacing: 15) {
			HStack {
				Image(systemName: "carrot")
					.renderingMode(.template)
				Text("Ingredients")
					.font(.custom(Fonts().robotoBold, size: 18))
				Spacer()
				if yield != nil {
					Text("\(yield!)")
						.font(.custom(Fonts().robotoBold, size: 18))
				}
			}
			Divider()
				.overlay(Color("CardColor"))
			ForEach(ingredients, id: \.referenceId) { ingredient in
				IngredientListView(ingredient: ingredient)
			}
		}
	}

	func instructionsList(instructions: [RecipeInstruction]) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack {
				Image(systemName: "list.number")
					.renderingMode(.template)
				Text("Instructions")
					.font(.custom(Fonts().robotoBold, size: 18))
			}
			Divider()
				.overlay(Color("CardColor"))
			ForEach(instructions.indices, id: \.self) { index in
				InstructionListView(instructionIndex: index + 1, instruction: instructions[index])
			}
		}
	}

	func notesList(notes: [RecipeNote]) -> some View {
		VStack(alignment: .leading) {
			Text("Notes")
				.font(.custom(Fonts().robotoBold, size: 18))
			Divider()
				.overlay(Color("CardColor"))
			ForEach(notes, id: \.text) { note in
				Text(note.text)
					.font(.custom(Fonts().robotoRegular, size: 14))
			}
		}
	}

	func tagList(tags: [RecipeTag]) -> some View {
		VStack(alignment: .leading) {
			HStack {
				Image(systemName: "tag.fill")
					.renderingMode(.template)
				Text("Tags")
					.font(.custom(Fonts().robotoBold, size: 18))
			}
			Divider()
				.overlay(Color("CardColor"))
			RecipeTagChip(tags: tags)
		}
	}

	func nutritionList(nutrition: RecipeNutrition) -> some View {
		NutritionLabelView(nutrition: nutrition)
	}

	var body: some View {
		ZStack {
			Color("LaunchScreenBg")
				.ignoresSafeArea(.all)
			ScrollView {
				VStack(alignment: .leading, spacing: 10) {
					if recipeViewModel.recipe != nil {
						recipeOverview(recipe: recipeViewModel.recipe!)
							.padding(.bottom, 20)
						VStack(alignment: .leading, spacing: 20) {
							ingredientsList(ingredients: recipeViewModel.recipe!.recipeIngredient,
							                yield: recipeViewModel.recipe!.recipeYield)
								.padding(.bottom, 20)
							instructionsList(instructions: recipeViewModel.recipe!.recipeInstructions)
								.padding(.bottom, 20)
							if !recipeViewModel.recipe!.notes.isEmpty {
								notesList(notes: recipeViewModel.recipe!.notes)
							}
							if !recipeViewModel.recipe!.tags.isEmpty {
								tagList(tags: recipeViewModel.recipe!.tags)
							}
							if recipeViewModel.recipe!.settings.showNutrition {
								nutritionList(nutrition: recipeViewModel.recipe!.nutrition)
							}
						}
						Spacer()
					}

				}.padding([.leading, .trailing])
				Spacer()
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Menu {
						Button {
							self.cookingModeAlert.toggle()
						} label: {
							HStack {
								Image(systemName: "cooktop")
									.renderingMode(.template)
								Text("Cook Mode")
							}
						}
						Button {} label: {
							HStack {
								Image(systemName: "square.and.arrow.up")
								Text("Share")
							}
						}
						Button(role: .destructive) {} label: {
							HStack {
								Image(systemName: "minus.circle")
								Text("Delete")
							}
						}
					} label: {
						Image(systemName: "line.3.horizontal")
					}
				}
			}
		}
		.onAppear { fetchRecipeDetails() }
		.alert("Enable Cooking Mode?", isPresented: $cookingModeAlert) {
			Button("Yes", role: .none) {
				showCookingMode.toggle()
			}
			Button("Cancel", role: .cancel) { self.cookingModeAlert.toggle() }
		}
		.sheet(isPresented: $showCookingMode) {
			ZStack {
				Color("LaunchScreenBg")
					.ignoresSafeArea(.all)
				CookModeView(instructions: recipeViewModel.recipe!.recipeInstructions)
					.padding()
			}
		}
		.navigationTitle(recipeName)
		.navigationBarTitleDisplayMode(.large)
	}
}

struct RecipeDetailViewPreview: PreviewProvider {
	static var previews: some View {
		RecipeDetailView(recipeSlug: "macro-friendly-sausage-egg-cheese-breakfast-sandwiches",
		                 recipeName: "Macro Friendly Sausage Egg Cheese Breakfast Sandwiches")
	}
}
