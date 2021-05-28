//
//  HTMLParser.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

class HTMLParser {
    private var link:String
    private var path:String

    init(link:String, path:String) {
        self.link = link
        self.path = path
    }

    func parse(completion: @escaping ([String]) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            let response = JiInterface.parseHTML(link: self.link, path: self.path)
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }

}
