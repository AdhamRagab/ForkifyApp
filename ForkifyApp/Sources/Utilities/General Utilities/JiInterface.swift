//
//  JiInterface.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation
import Ji

class JiInterface {
    static func parseHTML(link:String, path:String) -> [String] {
        var contents = [String]()
        let jiDoc = Ji(htmlURL: URL(string: link)!)
        jiDoc?.xPath("/\(path)")?.first?.forEach({ node in
            guard let content = node.content else {return}
            contents.append(content)
        })
        return contents
    }
}
