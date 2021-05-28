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

    let viewModel = RecipesListViewModel()
    var mealQuery: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes List"
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        reloadTableView()
        registerNib()
        viewModel.fetchRecipes(query: mealQuery)
    }

    private func reloadTableView() {
        viewModel.reloadTableView = { [weak self] in
            self?.recipesTableView.reloadData()
        }
    }

    private func registerNib() {
        recipesTableView.registerCell(ofType: RecipesListTableViewCell.self)
    }

    private func getCellModel(atIndex index: Int) -> RecipeListItemModel? {
        viewModel.getRecipeModel(atIndex: index)
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
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewCellHeight
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewCellHeight
    }
}
