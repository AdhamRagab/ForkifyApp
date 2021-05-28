//
//  RecipeDetails.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

struct RecipeDetails: Codable {
    var recipe: RecipeDetailsData
}

struct RecipeDetailsData: Codable {
    var publisher, title, sourceUrl, recipeId, imageUrl, publisherUrl: String?
    var ingredients: [String]?
}
