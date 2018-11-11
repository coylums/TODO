//
//  AppDelegate.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let todoListViewModel = ListViewControllerModel(DataModelService())
        let listViewController = ListViewController(todoListViewModel)

        let navigationController = UINavigationController(rootViewController: listViewController)
        navigationController.view.backgroundColor = .white

        let rootViewController = navigationController

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}
