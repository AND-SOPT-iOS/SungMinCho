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
        
        keyChainManager.removeValue()
        if let id = UserDefaults.standard.string(forKey: "id"),
           let password = UserDefaults.standard.string(forKey: "password") {
            apiService.login(username: id, password: password) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    let rootViewController = TabBarViewController()
                    window?.rootViewController = rootViewController
                case .failure:
                    let rootViewController = LoginViewController(apiService: apiService)
                    window?.rootViewController = UINavigationController(rootViewController: rootViewController)
                }
            }
        } else {
            let rootViewController = LoginViewController(apiService: apiService)
            window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        }
        
        window?.makeKeyAndVisible()
    }
    
}

