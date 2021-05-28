//
//  TargetTypeExt.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        URL(string: "https://forkify-api.herokuapp.com/api")!
    }

    var headers: [String: String]? {
        [
//            "Content-Type": "application/json",
//            "client": "",
//            "uid": "",
//            "access-token": "",
            "Accept": "application/json"
//            "lang": ""
        ]
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    var sampleData: Data {
        return Data()
    }
}
