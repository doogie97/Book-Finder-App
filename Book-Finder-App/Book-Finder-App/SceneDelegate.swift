//
//  SceneDelegate.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let container = Container()
        
        let navigationViewController = UINavigationController(rootViewController: container.mainViewController())
        navigationViewController.isNavigationBarHidden = true
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

