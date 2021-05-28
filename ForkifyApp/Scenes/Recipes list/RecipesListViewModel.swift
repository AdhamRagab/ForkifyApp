//
//  RecipesViewModel.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit

class RecipesListViewModel {

    var reloadTableView: (() -> Void)?
    var errorHandler: ((ForkifyError) -> Void)?

    let model = RecipesListModel()
    var recipe: Recipe? {
        didSet {
            reloadTableView?()
        }
    }

    func getNumberOfRows() -> Int {
        recipe?.count ?? 0
    }

    func getRecipeModel(atIndex index: Int) -> RecipeListItemModel? {
        guard let imageLink = recipe?.recipes?[index].imageUrl else { return RecipeListItemModel()}
        return RecipeListItemModel(
            recipeImageLink: imageLink,
            recipeTitle: recipe?.recipes?[index].title,
            recipePublisherName: recipe?.recipes?[index].publisher
        )
    }

    func fetchRecipes(query: String?) {
        model.fetchRecipes(query: query) { result in
            switch result {
            case .success(let recipe as Recipe):
                self.recipe = recipe
            case .failure(let error):
                self.errorHandler?(error)
            default:
                return
            }
        }
    }
}
