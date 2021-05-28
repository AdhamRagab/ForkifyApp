//
//  Result.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

enum Result {
    case success(Decodable)
    case failure(ForkifyError)
}

