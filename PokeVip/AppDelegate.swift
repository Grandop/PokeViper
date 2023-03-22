//
//  AppDelegate.swift
//  PokeVip
//
//  Created by Matheus Bondan on 09/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let navigator = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ODNavigation.shared.setup(style: .light)
        AppRouter.shared.navigator = navigator
        makeViewController()
        
        return true
    }

    private func makeViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let initial = PVInitialCoordinator()
        initial.navigator = navigator
        window?.rootViewController = navigator
        window?.makeKeyAndVisible()
        initial.start()
    }
}

