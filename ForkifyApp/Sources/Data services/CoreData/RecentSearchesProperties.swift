//
//  RecentSearchesProperties.swift
//  ForkifyApp
//
//  Created by Adham on 29/05/2021.
//

import Foundation
import CoreData


extension RecentSearches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearches> {
        return NSFetchRequest<RecentSearches>(entityName: "RecentSearches")
    }

    @NSManaged public var searchQuery: String?

}
