//
//  ErrorModel.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation

struct ErrorModel: Codable {
    var success: Bool?
    var errors: [String]?
}

