//
//  HomeView.swift
//  Mealios
//
//  Created by Daniel Ries on 7/30/23.
//

import Alamofire
import SwiftUI

class HomeViewModel: ObservableObject {
	@Published var loading = false
	@Published var recipes: [Recipe] = []
	@Published var page = 1
	@Published var totalPages = 1
	@Published var searchedRecipes: [Recipe] = []

	@Published var searchText: String = "" {
		willSet {
			if !searchText.isEmpty {
				searchedRecipes = recipes.filter { $0.name.contains(searchText) }
			} else {
				searchedRecipes = recipes
			}
		}
	}
}

struct HomeView: View {
	let appSettings = AppSettings.shared
	@ObservedObject var viewModel = HomeViewModel()

    init() {
        fetchRecipes()
    }

	func fetchRecipes() {
		viewModel.loading = true
		let authHeader: HTTPHeaders = [.authorization(bearerToken: appSettings.apiToken)]
		AF.request("\(appSettings.serverUrl)\(APIPaths.getRecipe)?page=\(viewModel.page)&perPage=10",
		           method: .get, headers: authHeader)
			.validate()
			.responseDecodable(of: Pageable<Recipe>.self) { response in
				switch response.result {
				case let .success(recipeResponse):
					viewModel.recipes.append(contentsOf: recipeResponse.items)
					viewModel.searchedRecipes.append(contentsOf: recipeResponse.items)
					viewModel.page += 1
					viewModel.totalPages = recipeResponse.totalPages
					viewModel.loading = false
				case let .failure(error):
					print(error)
					viewModel.loading = false
				}
			}
	}

	func shouldLoadData(index: Int) -> Bool {
		return (index == viewModel.recipes.count - 2) && viewModel.page <= viewModel.totalPages
	}

	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
	]

	var body: some View {
		NavigationStack {
			ZStack {
				Color("LaunchScreenBg")
					.ignoresSafeArea(.all)
				ScrollView {
					if viewModel.loading && viewModel.recipes.count == 0 {
						LottieView(name: "pizza", loopMode: .loop)
					} else {
						if UIDevice.current.name.starts(with: "iPad") {
							LazyVGrid(columns: columns, spacing: 20) {
								ForEach(viewModel.searchedRecipes.indices, id: \.self) { index in
									NavigationLink {
										RecipeDetailView(recipeSlug: viewModel.searchedRecipes[index].slug,
										                 recipeName: viewModel.searchedRecipes[index].name)
									} label: {
										RecipeCard(recipe: viewModel.searchedRecipes[index])
											.padding(10)
											.onAppear {
												if shouldLoadData(index: index) {
													fetchRecipes()
												}
											}
									}
								}
							}
						} else {
							LazyVStack {
								ForEach(viewModel.searchedRecipes.indices, id: \.self) { index in
									NavigationLink {
										RecipeDetailView(recipeSlug: viewModel.searchedRecipes[index].slug,
										                 recipeName: viewModel.searchedRecipes[index].name)
									} label: {
										RecipeCard(recipe: viewModel.searchedRecipes[index])
											.padding(10)
											.onAppear {
												if shouldLoadData(index: index) {
													fetchRecipes()
												}
											}
									}
								}
							}
						}
					}
				}
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						NavigationLink {
							SettingsView()
						} label: {
							Image(systemName: "gearshape")
                        }
                        .accessibilityIdentifier("settings-button")
					}
				}
				.accentColor(Color("CardColor"))
				.searchable(text: $viewModel.searchText, placement: .toolbar, prompt: "Search for Recipes...")
			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
