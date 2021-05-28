//
//  MealsListViewModel.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

class MealsListViewModel {

    var reloadTableView: (() -> Void)?

    var recentlySearchedMeals = [String]()
    var meals = [String]()
    var fetchedMeals = [String]()

    func fetchMeals() {
        if recentlySearchedMeals.count == 0 {
            HTMLParser(link: "https://forkify-api.herokuapp.com/phrases.html", path: "/body/div/ul").parse(completion: { meals in
                self.meals = meals
                self.fetchedMeals = meals
                self.reloadTableView?()
            })
        } else {
            meals = recentlySearchedMeals
            reloadTableView?()
        }
    }

    func getNumberOfRows() -> Int {
        meals.count
    }

    func getMealName(atIndex index: Int) -> String {
        meals[index]
    }

    func filterMeals(withQuery query: String) {
        meals = !query.isEmpty ? meals.filter { $0.contains(query) } : fetchedMeals
        reloadTableView?()
    }
}
