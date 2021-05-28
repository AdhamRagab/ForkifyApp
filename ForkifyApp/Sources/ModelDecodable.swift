//
//  ModelDecodable.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.


import Foundation
import Moya

protocol ModelDecodable {
    func decode<Model: Decodable>(modelType: Model.Type, from response: Response, completionHandler: @escaping (Result) -> Void)
    func decodeError(response: Response, completionHandler: @escaping (Result) -> Void)
}

extension ModelDecodable {
    func decode<Model: Decodable>(modelType: Model.Type, from response: Response, completionHandler: @escaping (Result) -> Void) {
        let decoded = decode(modelType: modelType, from: response.data)
        if let decodedData = decoded.data {
            completionHandler(.success(decodedData))
        } else if let error = decoded.catchedError {
            completionHandler(.failure(ForkifyError(type: .parsingError, message: error)))
        }
    }

    func decodeError(response: Response, completionHandler: @escaping (Result) -> Void) {
        let error = decode(modelType: ErrorModel.self, from: response.data)
        if let error = error.data {
            let customError = ForkifyError(type: .serverSideError(), message: error.errors?[0] ?? "")
            completionHandler(.failure(customError))
        } else if let error = error.catchedError {
            completionHandler(.failure(ForkifyError(type: .parsingError, message: error)))
        }
    }

    private func decode<T: Decodable>(modelType: T.Type, from data: Data) -> (data: T?, catchedError: String?) {
        do {
            let decodedData = try JSONDecoder.default.decode(modelType, from: data)
            return (decodedData, nil)
        } catch {
            return (nil, "Something went wrong while decoding the data")
        }
    }
}
