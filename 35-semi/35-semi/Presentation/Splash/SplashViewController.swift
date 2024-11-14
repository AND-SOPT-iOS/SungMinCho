//
//  SplashViewController.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

import UIKit

final class SplashViewController: BaseViewController {

    private let apiService: APIService
    private let keyChainManager: KeyChainManager
    
    init(apiService: APIService, keyChainManager: KeyChainManager) {
        self.apiService = apiService
        self.keyChainManager = keyChainManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAutoLogin()
    }
    
    override func setStyle() {
        view.backgroundColor = .systemBackground
    }
    
    private func checkAutoLogin() {
        keyChainManager.removeValue()
        if let id = UserDefaults.standard.string(forKey: "id"),
           let password = UserDefaults.standard.string(forKey: "password") {
            apiService.login(username: id, password: password) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    let tabBarViewController = TabBarViewController(
                        apiService: apiService,
                        keyChainManager: keyChainManager
                    )
                    navigationController?.pushViewController(tabBarViewController, animated: false)
                case .failure:
                    UserDefaults.standard.removeObject(forKey: "id")
                    UserDefaults.standard.removeObject(forKey: "password")
                    let loginViewController = LoginViewController(
                        apiService: apiService,
                        keyChainManager: keyChainManager
                    )
                    navigationController?.pushViewController(loginViewController, animated: false)
                }
            }
        } else {
            let loginViewController = LoginViewController(
                apiService: apiService,
                keyChainManager: keyChainManager
            )
            navigationController?.pushViewController(loginViewController, animated: false)
        }
    }
    
}
