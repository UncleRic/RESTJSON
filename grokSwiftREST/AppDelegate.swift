//
//  AppDelegate.swift
//  grokSwiftREST
//
//  Created by Christina Moulton on 2016-10-29.
//  Copyright © 2016 Teak Mobile Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as? UISplitViewController
        let navigationController = splitViewController?.viewControllers[(splitViewController?.viewControllers.count)!-1] as? UINavigationController
        navigationController?.topViewController!.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        splitViewController?.delegate = self
        return true
    }
    
    // MARK: - Split view
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController =
            secondaryViewController as? UINavigationController else {
                return false
        }
        guard let topAsDetailController =
            secondaryAsNavController.topViewController as? DetailViewController else {
                return false
        }
        if topAsDetailController.gist == nil {
            // Return true to indicate that we have handled the collapse by doing nothing;
            // the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        GitHubAPIManager.sharedInstance.processOAuthStep1Response(url)
        return true
    }
}
