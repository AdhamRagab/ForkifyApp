//
//  StringExt.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation

extension String {
    var configuredImageLink: String {
        var link = ""
        link = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        link = self.replacingOccurrences(of: "http", with: "https")
        return link
    }
}
