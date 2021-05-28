//
//  ForkifyError.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

enum ErrorType: Equatable {
    case validationError
    case serverSideError(statusCode: Int? = nil)
    case connectivityError
    case parsingError
}

struct ForkifyError: Error {
    var type: ErrorType
    var message: String

    init(type: ErrorType, message: String = "") {
        self.type = type
        self.message = message
    }
}
