//
//  AppDelegate.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import UIKit
import CoreData

typealias AppDelegateType = UIResponder & UIApplicationDelegate

@UIApplicationMain
class AppDelegate: AppDelegateType {
    static func getAppDelegate() -> AppDelegate! {
        return UIApplication.shared.delegate as? AppDelegate
    }

    var window: UIWindow?
    var appDelegateComposer = AppDelegateFactory.makeDefault()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = appDelegateComposer.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ForkifyApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
