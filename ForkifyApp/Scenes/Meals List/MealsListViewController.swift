//
//  MealsListViewController.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit

class MealsListViewController: UIViewController {
    @IBOutlet private var mealsTableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!

    private let viewModel = MealsListViewModel()
    var query: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meals List"
        self.hideKeyboardWhenTappedAround()
        reloadTableView()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
    }

    private func reloadTableView() {
        viewModel.reloadTableView = { [weak self] in
            self?.mealsTableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchMeals()
    }

    private func navigateToRecipesList(query: String) {
        guard let recipesViewController = UIStoryboard(name: "RecipesList", bundle: nil).instantiateViewController(withIdentifier: "RecipesListViewController") as? RecipesListViewController else { return }
        recipesViewController.mealQuery = query
        self.searchBar.endEditing(true)
        self.searchBar.text?.removeAll()
        self.mealsTableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        navigationController?.pushViewController(recipesViewController, animated: true)
    }
}

extension MealsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealsListTableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.getMealName(atIndex: indexPath.row)
        return cell
    }
}

extension MealsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CoreDataHandler.shared.checkIfSearchExists(searchQuery: viewModel.getMealName(atIndex: indexPath.row))
        navigateToRecipesList(query: viewModel.getMealName(atIndex: indexPath.row))
    }
}

extension MealsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query = searchText
        if query?.count == 1 {
            viewModel.clearCachedMeals()
            viewModel.fetchMeals()
        }
        viewModel.filterMeals(withQuery: query ?? "")
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.getRecentSearches()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? false {
            viewModel.clearCachedMeals()
        }
    }
}
