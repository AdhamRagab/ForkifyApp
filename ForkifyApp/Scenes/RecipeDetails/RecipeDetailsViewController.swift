//
//  RecipeDetailsViewController.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import SafariServices
import UIKit

class RecipeDetailsViewController: UIViewController {
    enum Constants {
        static var tableViewCellHeight: CGFloat = 55
    }

    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var recipeName: UILabel!
    @IBOutlet private var recipeIngredientsTableView: UITableView!
    @IBOutlet private var publisherSiteButton: UIButton!

    private let viewModel = RecipeDetailsViewModel()
    var recipeId: Int? = nil {
        didSet {
            viewModel.fetchRecipeDetails(recipeId: recipeId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
        recipeIngredientsTableView.dataSource = self
        recipeIngredientsTableView.delegate = self
        registerNib()
        errorHandler()
        refreshView()
    }
    @IBAction private func visitPublishersWebsite(_ sender: Any) {
        guard let url = viewModel.getRecipeDetails()?.sourceUrl?.configuredImageLink else { return }
        setExternalURLHandler(url: URL(string: url))
    }

    private func registerNib() {
        recipeIngredientsTableView.registerCell(ofType: RecipeDetailsTableViewCell.self)
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

    private func refreshView() {
        viewModel.refreshView = { [weak self] recipeDetails in
            self?.recipeImageView.kf.setImage(with: URL(string: recipeDetails.imageUrl?.configuredImageLink ?? ""))
            self?.recipeName.text = recipeDetails.title
            self?.recipeIngredientsTableView.reloadData()
        }
    }

    private func setExternalURLHandler(url: URL?) {
        guard let linkURL = url else { return }
        let safariViewController = SFSafariViewController(url: linkURL)
        self.present(safariViewController, animated: true)
    }
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: RecipeDetailsTableViewCell.self, for: indexPath) else { return UITableViewCell() }
        cell.configure(ingredient: viewModel.getRecipeDetails()?.ingredients?[indexPath.row] ?? "")
        return cell
    }
}

extension RecipeDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewCellHeight
    }
}


