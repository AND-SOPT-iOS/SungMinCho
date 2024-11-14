//
//  TabBarController.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    init(apiService: APIService, keyChainManager: KeyChainManager) {
        super.init(nibName: nil, bundle: nil)
        configureSubTabs(apiService: apiService, keyChainManager: keyChainManager)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
    }
    
    private func configureSubTabs(apiService: APIService, keyChainManager: KeyChainManager) {
        let mainViewController = MainViewController()
        let myPageViewController = MyPageViewController(
            apiService: apiService,
            keyChainManager: keyChainManager
        )
        
        mainViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        myPageViewController.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        let mainNavigationController = UINavigationController(
            rootViewController: mainViewController
        )
        let myPageNavigationController = UINavigationController(
            rootViewController: myPageViewController
        )
        
        setViewControllers([mainNavigationController, myPageNavigationController], animated: false)
    }
    
}
