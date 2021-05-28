//
//  RecipeDetailsTableViewCell.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit

class RecipeDetailsTableViewCell: UITableViewCell {
    @IBOutlet private var ingredientLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(ingredient: String) {
        ingredientLabel.text = ingredient
    }
}
