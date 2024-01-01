//
//  Paths.swift
//  Mealios
//
//  Created by Daniel Ries on 7/30/23.
//

import Foundation

enum APIPaths {
	// MARK: - SERVER INFO

	static var getAppInfo = "/api/app/about"

	// MARK: - AUTH

	static var getUserToken = "/api/auth/token"
	static var createApiToken = "/api/users/api-tokens"
	static var deleteApiToken = "/api/users/api-tokens/${TOKEN}"

	// MARK: - RECIPES

	static var getRecipeSummaries = "/api/recipes/summary?start=0&limit=9999"
	static var getRecipe = "/api/recipes"
	static var getRecipeTags = "/api/tags"

	// MARK: - MEDIA

	static var recipeImage = "/api/media/recipes/${RECIPE_ID}/images/min-original.webp"
}
