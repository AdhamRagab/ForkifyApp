//
//  FileReader.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.


import Foundation

enum FileType: String {
    case plist
    case json
}

final class FileReader {
    static func parse<T: Decodable>(file: String, ofType fileType: FileType, to type: T.Type) throws -> T {
        guard let filePath = Bundle(for: self).path(forResource: file, ofType: fileType.rawValue) else { preconditionFailure("Error getting file path") }
        let url = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: url)

        let decodedData: T
        switch fileType {
        case .plist:
            let decoder = PropertyListDecoder()
            decodedData = try decoder.decode(type, from: data)
        case .json:
            let decoder = JSONDecoder()
            decodedData = try decoder.decode(type, from: data)
        }
        return decodedData
    }
}
