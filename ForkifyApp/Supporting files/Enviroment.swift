//
//  Enviroment.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.

import Foundation

enum Environment {
    static let rootURL: URL = {
        guard let url = URL(string: propertyListKeyValuePair.rootUrl) else { fatalError("Root URL is invalid") }
        return url
    }()

    static let baseURL: URL = {
        guard let url = URL(string: propertyListKeyValuePair.baseUrl) else { fatalError("Base URL is invalid") }
        return url
    }()

    static let baseURLString: String = {
        return propertyListKeyValuePair.baseUrl
    }()

    static var imageUrl: (String) -> URL = { imagePath in
        guard let url = URL(string: "\(baseURLString)\(imagePath)") else { fatalError("Image URL is invalid") }
        return url
    }

    private static var propertyListKeyValuePair: PropertyListKeyValuePair {
        do {
            return try FileReader.parse(file: "Info", ofType: .plist, to: PropertyListKeyValuePair.self)
        } catch {
            fatalError("Unable to parse Info.plist file")
        }
    }
}
