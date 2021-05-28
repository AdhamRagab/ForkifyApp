//
//  Recipe.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

struct Recipe: Codable {
    var count: Int?
    var recipes: [RecipeDetail]?
}

struct RecipeDetail: Codable {
    var publisher, title, sourceUrl, recipeId, imageUrl, publisherUrl: String?
}
