//
//  RecipesListTableViewCell.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit
import Kingfisher

struct RecipeListItemModel {
    var recipeImageLink: String?
    var recipeTitle: String?
    var recipePublisherName: String?
}

class RecipesListTableViewCell: UITableViewCell {

    @IBOutlet private var recipeImage: UIImageView!
    @IBOutlet private var recipeTitleLabel: UILabel!
    @IBOutlet private var recipePublisherNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configureView(recipeModel: RecipeListItemModel?) {
        guard let imageLink = recipeModel?.recipeImageLink?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let securedImageLink = imageLink.replacingOccurrences(of: "http", with: "https")
        recipeImage.kf.setImage(with: URL(string: securedImageLink))
        recipeTitleLabel.text = recipeModel?.recipeTitle ?? ""
        recipePublisherNameLabel.text = recipeModel?.recipePublisherName ?? ""
    }

}
