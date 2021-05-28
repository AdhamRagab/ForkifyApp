//
//  ScreenFlowsAppDelegate.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation
import UIKit

class ScreensFlowConfigurationAppDelegate: AppDelegateType {
    static var shared = ScreensFlowConfigurationAppDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        navigateToMainScreen()
        return true
    }

    func navigateToMainScreen() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window
        else {
            return
        }
        window.rootViewController = UIStoryboard(name: "MealsList", bundle: nil).instantiateViewController(withIdentifier: "MealsListNavigationController")
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
    }
}
