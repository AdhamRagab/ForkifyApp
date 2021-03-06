//
//  RecipesModel.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

class RecipesListModel: ModelDecodable {
    private let apiClient = RecipesListApiClient()

    func fetchRecipes(query: String?, completionHandler: @escaping (Result) -> Void) {
        apiClient.fetchRecipes(query: query) { response, error in
            if let response = response {
                if response.statusCode < 300 {
                    self.decode(modelType: Recipe.self, from: response) { result in
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

