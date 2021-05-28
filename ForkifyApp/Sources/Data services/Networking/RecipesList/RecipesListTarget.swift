//
//  RecipesListApiClient.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation
import Moya

enum RecipesListTarget {
    case fetchRecipes(query: String)
    case fetchRecipeDetails(recipeId: Int)
}

extension RecipesListTarget: TargetType {

    var path: String {
        switch self {
        case .fetchRecipes:
           return "/search"
        case .fetchRecipeDetails:
           return "/get"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case let .fetchRecipes(query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding(destination: .queryString))
        case let .fetchRecipeDetails(recipeId):
            return .requestParameters(parameters: ["rId": recipeId], encoding: URLEncoding(destination: .queryString))
        }
    }
}
