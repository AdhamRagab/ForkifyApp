//
//  CoreDataHandler.swift
//  ForkifyApp
//
//  Created by Adham on 29/05/2021.
//

import UIKit
import CoreData

class CoreDataHandler{

    static var shared = CoreDataHandler()
    var recentSearches = [RecentSearches]()
    let managedObject = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init(){
        managedObject.parent = context
    }

    // MARK:- Fetch RecentSearches
    func fetchRecentSearches() {
        do {
            self.recentSearches =  try context.fetch(RecentSearches.fetchRequest())
            if recentSearches.count > 10 {
                self.context.delete(recentSearches.first ?? RecentSearches())
                self.saveSearch()
            }
        }
        catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK:- Add Search
    public func addSearch(searchQuery:String) {
        managedObject.performAndWait {
            let newRecentSearch = RecentSearches(context: managedObject)
            newRecentSearch.searchQuery = searchQuery
            saveContext(forContext: managedObject)
        }
        self.saveSearch()
    }

    // MARK:- Save Search
    func saveSearch() {
        do {
            try context.save()
        }
        catch let error {
            print("Save Search History error :", error)
        }
        fetchRecentSearches()
    }

    func saveContext(forContext context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait{
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    print("Error when saving !!! \(nserror.localizedDescription)")
                    print("Callstack :")
                    for symbol: String in Thread.callStackSymbols {
                        print(" > \(symbol)")
                    }
                }
            }
        }
    }

    // MARK:- Get All Search History
    func getAllSearchHistory() -> [String] {
        var result = [String]()
        fetchRecentSearches()
        recentSearches.forEach { search in
            result.append(search.searchQuery ?? "")
        }
        return result
    }

    func checkIfSearchExists(searchQuery: String) {
        let request : NSFetchRequest<RecentSearches> = RecentSearches.fetchRequest()
        let predicate = NSPredicate(format: "searchQuery = %@", searchQuery)
        request.predicate = predicate
        request.fetchLimit = 1
        do{
            let count = try context.count(for: request)
            if(count == 0){
                addSearch(searchQuery: searchQuery)
            }
            else{
                print("match found")
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

