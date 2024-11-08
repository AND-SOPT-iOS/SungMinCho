//
//  SceneDelegate.swift
//  35-semi
//
//  Created by 조성민 on 10/5/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let keyChainManager = DefaultKeyChainManager()
        let apiService = APIService(keyChainManager: keyChainManager)
        
        let rootViewController = SplashViewController(
            apiService: apiService,
            keyChainManager: keyChainManager
        )
        let navigationController = UINavigationController(
            rootViewController: rootViewController
        )
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

