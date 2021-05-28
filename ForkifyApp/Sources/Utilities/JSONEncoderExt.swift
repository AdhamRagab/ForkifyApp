//
//  JSONEncoderExt.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation

extension JSONEncoder {
    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

