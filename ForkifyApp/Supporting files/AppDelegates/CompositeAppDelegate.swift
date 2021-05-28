//
//  CompositeAppDelegate.swift
//  ForkifyApp
//
//  Created by Adham on 28/05/2021.
//

import Foundation
import UIKit

enum AppDelagateIndex: Int, CaseIterable {
    case screensFlow
}

enum AppDelegateFactory {
    static func makeDefault() -> CompositeAppDelegate {
        CompositeAppDelegate(
            appDelegates: [
                ScreensFlowConfigurationAppDelegate()
            ]
        )
    }
}

class CompositeAppDelegate: AppDelegateType {
    private let appDelegates: [AppDelegateType]

    init(appDelegates: [AppDelegateType]) {
        assert(appDelegates.count == AppDelagateIndex.allCases.count, "App Delegates Count and Indices are not matching")
        self.appDelegates = appDelegates
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }

    func appDelegate(at index: AppDelagateIndex) -> AppDelegateType {
        appDelegates[index.rawValue]
    }
}
