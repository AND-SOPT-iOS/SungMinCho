//
//  TabItems.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

import UIKit

enum TabItems: Int, CaseIterable {
    
    case main
    case myPage
    
    var tabBarItem: UITabBarItem {
        UITabBarItem(
            title: title,
            image: image,
            selectedImage: selectedImage
        )
    }
    
    // TODO: APIService 주입?
    var viewController: UIViewController {
        switch self {
        case .main:
            MainViewController()
        case .myPage:
            MyPageViewController(
                apiService: APIService(
                    keyChainManager: DefaultKeyChainManager()
                )
            )
        }
    }
    
    private var title: String {
        switch self {
        case .main:
            "Home"
        case .myPage:
            "MyPage"
        }
    }
    
    private var image: UIImage? {
        switch self {
        case .main:
            UIImage(systemName: "house")
        case .myPage:
            UIImage(systemName: "person")
        }
    }
    
    private var selectedImage: UIImage? {
        switch self {
        case .main:
            UIImage(systemName: "house.fill")
        case .myPage:
            UIImage(systemName: "person.fill")
        }
    }
    
}
