//
//  RecipesViewModel.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit

class RecipeDetailsViewModel {

    var errorHandler: ((ForkifyError) -> Void)?
    var refreshView: ((RecipeDetailsData) -> Void)?

    let model = RecipeDetailsModel()
    var recipeDetails: RecipeDetailsData?

    func getNumberOfRows() -> Int {
        recipeDetails?.ingredients?.count ?? 0
    }

    func getRecipeDetails() -> RecipeDetailsData? {
        recipeDetails
    }

    func fetchRecipeDetails(recipeId: Int?) {
        model.fetchRecipeDetails(recipeId: recipeId) { result in
            switch result {
            case .success(let recipeDetails as RecipeDetails):
                self.recipeDetails = recipeDetails.recipe
                self.refreshView?(recipeDetails.recipe)
            case .failure(let error):
                self.errorHandler?(error)
            default:
                return
            }
        }
    }
}
