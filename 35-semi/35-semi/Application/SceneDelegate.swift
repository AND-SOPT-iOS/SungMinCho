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
        // TODO: 삭제해야 함
        DefaultKeyChainManager.shared.removeValue()
        let rootViewController = LoginViewController(apiService: APIService(keyChainManager: DefaultKeyChainManager()))
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

