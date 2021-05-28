//
//  RecipeModel.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

class RecipeDetailsModel: ModelDecodable {
    private let apiClient = RecipesListApiClient()

    func fetchRecipeDetails(recipeId: Int?, completionHandler: @escaping (Result) -> Void) {
        apiClient.fetchRecipeDetails(recipeId: recipeId) { response, error in
            if let response = response {
                if response.statusCode < 300 {
                    self.decode(modelType: RecipeDetails.self, from: response) { result in
                        completionHandler(result)
                    }
                } else {
                    self.decodeError(response: response, completionHandler: completionHandler)
                }
            } else if let error = error {
                completionHandler(.failure(ForkifyError(type: .parsingError, message: error)))
            }
        }
    }
}
