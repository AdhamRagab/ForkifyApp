//
//  RecipesListApiClient.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation
import Moya

class RecipesListApiClient {
    let recipesListProvider = MoyaProvider<RecipesListTarget>()

    func fetchRecipes(query: String?, completionHandler: @escaping (Response?, String?) -> Void) {
        guard let query = query else { return }
        recipesListProvider.request(.fetchRecipes(query: query)) { result in
            switch result {
            case .success(let response):
                completionHandler(response, nil)
            case .failure:
                completionHandler(nil, "")
            }
        }
    }

    func fetchRecipeDetails(recipeId: Int?, completionHandler: @escaping (Response?, String?) -> Void) {
        guard let recipeId = recipeId else { return }
        recipesListProvider.request(.fetchRecipeDetails(recipeId: recipeId)) { result in
            switch result {
            case .success(let response):
                completionHandler(response, nil)
            case .failure:
                completionHandler(nil, "")
            }
        }
    }
}

