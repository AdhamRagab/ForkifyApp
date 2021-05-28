//
//  PropertyListKeyValuePair.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

struct PropertyListKeyValuePair: Decodable {
    private enum CodingKeys: String, CodingKey {
        case baseUrl = "BASE_URL"
        case rootUrl = "ROOT_URL"
    }

    var baseUrl: String
    var rootUrl: String
}
