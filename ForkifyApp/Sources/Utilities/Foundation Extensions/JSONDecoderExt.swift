//
//  JSONDecoderExt.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
