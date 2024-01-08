//
//  ResponseModels.swift
//  Mealios
//
//  Created by Daniel Ries on 7/29/23.
//

import Foundation

// MARK: - APP INFO

struct AppInfo: Codable {
	var production: Bool
	var version: String
	var demoStatus: Bool
	var allowSignup: Bool
}

// MARK: - Authentication

struct UserTokenResponse: Codable {
	var token: String
	var type: String

	enum CodingKeys: String, CodingKey {
		case token = "access_token"
		case type = "token_type"
	}
}

struct APITokenResponse: Codable {
	var token: String
	var name: String
	var id: Int
}

// MARK: - Recipes

struct RecipeIngredient: Codable {
	var quantity: Double?
	var unit: IngredientUnit?
	var food: IngredientFood
	var note: String
	var isFood: Bool
	var disableAmount: Bool
	var display: String
	var title: String?
	var originalText: String
	var referenceId: String
}

struct IngredientFood: Codable {
	var name: String
	var pluralName: String?
	var description: String
	var labelId: String?
	var aliases: [String]?
	var id: String
	var label: MultiPurposeLabelSummary?
	var createdAt: String
	var updateAt: String
}

struct IngredientUnit: Codable {
	var name: String
	var pluralName: String?
	var description: String
	var fraction: Bool
	var abbreviation: String
	var pluralAbbreviation: String?
	var useAbbreviation: Bool
	var id: String
	var aliases: [String]?
	var createdAt: String
	var updateAt: String
}

struct MultiPurposeLabelSummary: Codable {
	var name: String
	var color: String
	var groupId: String
	var id: String
}

struct RecipeNutrition: Codable {
	var calories: String?
	var fatContent: String?
	var proteinContent: String?
	var carbohydrateContent: String?
	var fiberContent: String?
	var sodiumContent: String?
	var sugarContent: String?
}

struct RecipeInstruction: Codable {
	var id: String
	var title: String?
	var text: String
	var ingredientReferences: [String]
}

struct RecipeNote: Codable {
	var title: String
	var text: String
}

struct RecipeSettings: Codable {
	var `public`: Bool
	var showNutrition: Bool
	var showAssets: Bool
	var landscapeView: Bool
	var disableComments: Bool
	var disableAmount: Bool
	var locked: Bool
}

struct Pageable<T>: Codable where T: Codable {
	var page: Int
	var perPage: Int
	var total: Int
	var totalPages: Int
	var items: [T]
	var next: String?
	var previous: String?

	enum CodingKeys: String, CodingKey {
		case page
		case perPage = "per_page"
		case total
		case totalPages = "total_pages"
		case items
		case next
		case previous
	}
}

struct Recipe: Codable {
	var id: String
	var userId: String
	var groupId: String
	var name: String
	var slug: String
	var image: String?
	var recipeYield: String?
	var totalTime: String?
	var prepTime: String?
	var cookTime: String?
	var performTime: String?
	var description: String
	var recipeCategory: [RecipeCategory]
	var tags: [RecipeTag]
	var rating: Int?
	var dateAdded: String
	var dateUpdated: String
	var createdAt: String
	var updateAt: String
	var lastMade: String?
}

struct RecipeDetails: Codable {
	var id: String
	var userId: String
	var groupId: String
	var name: String
	var slug: String
	var image: String?
	var recipeYield: String?
	var totalTime: String?
	var prepTime: String?
	var cookTime: String?
	var performTime: String?
	var description: String
	var recipeCategory: [RecipeCategory]
	var tags: [RecipeTag]
	var tools: [RecipeTool]
	var rating: Int?
	var orgUrl: String?
	var dateAdded: String?
	var dateUpdated: String?
	var createdAt: String?
	var updateAt: String?
	var lastMade: String?
	var recipeIngredient: [RecipeIngredient]
	var recipeInstructions: [RecipeInstruction]
	var nutrition: RecipeNutrition
	var settings: RecipeSettings
	var assets: [RecipeAsset]
	var notes: [RecipeNote]
	var comments: [RecipeComment]
}

struct RecipeAsset: Codable {
	var name: String
	var icon: String
	var fileName: String?
}

struct RecipeTool: Codable {
	var id: String
	var name: String
	var slug: String
	var onHand: Bool
}

struct RecipeTag: Codable {
	var id: String
	var name: String
	var slug: String
}

struct RecipeCategory: Codable {
	var id: String
	var name: String
	var slug: String
}

struct RecipeComment: Codable {
	var recipeId: String
	var text: String
	var id: String
	var createdAt: String
	var updateAt: String
	var userId: String
	var user: MealieUser
}

struct MealieUser: Codable {
	var id: String
	var username: String?
	var admin: Bool
}

struct TokenDeleteResponse: Codable {
	var tokenDelete: String
}
