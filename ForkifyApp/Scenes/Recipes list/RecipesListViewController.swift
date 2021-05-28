//
//  RecipesListViewController.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit

class RecipesListViewController: UIViewController {

    enum Constants {
        static var tableViewCellHeight: CGFloat = 150
    }

    @IBOutlet private var recipesTableView: UITableView!

    private let viewModel = RecipesListViewModel()
    var mealQuery: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes List"
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        reloadTableView()
        errorHandler()
        registerNib()
        viewModel.fetchRecipes(query: mealQuery)
    }

    private func reloadTableView() {
        viewModel.reloadTableView = { [weak self] in
            self?.recipesTableView.reloadData()
        }
    }

    private func errorHandler() {
        viewModel.errorHandler = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self?.dismiss(animated: true)
            }))
            self?.present(alert, animated: true)
        }
    }

    private func registerNib() {
        recipesTableView.registerCell(ofType: RecipesListTableViewCell.self)
    }

    private func getCellModel(atIndex index: Int) -> RecipeListItemModel? {
        viewModel.getRecipeModel(atIndex: index)
    }

    private func navigateToRecipeDetails(withId id: Int) {
        guard let recipesViewController = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController else { return }
        recipesViewController.recipeId = id
        navigationController?.pushViewController(recipesViewController, animated: true)
    }
}

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: RecipesListTableViewCell.self, for: indexPath) else { return UITableViewCell() }
        cell.configureView(recipeModel: getCellModel(atIndex: indexPath.row))
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToRecipeDetails(withId: viewModel.getRecipeId(atIndex: indexPath.row))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewCellHeight
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewCellHeight
    }
}
