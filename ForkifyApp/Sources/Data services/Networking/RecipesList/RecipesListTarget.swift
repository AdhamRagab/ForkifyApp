//
//  RecipesListApiClient.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation
import Moya

enum RecipesListTarget {
    case fetchRecipes(query: String)
}

extension RecipesListTarget: TargetType {

    var path: String {
        return "/search"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case let .fetchRecipes(query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding(destination: .queryString))
        }
    }
}
