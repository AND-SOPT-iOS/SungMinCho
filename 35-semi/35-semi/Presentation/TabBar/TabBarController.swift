//
//  TabBarController.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setStyle()
        configureSubTabs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStyle() {
        view.backgroundColor = .systemBackground
        modalPresentationStyle = .fullScreen
    }
    
    private func configureSubTabs() {
        let viewControllers = TabItems.allCases.map { item in
            let controller = item.viewController
            controller.tabBarItem = item.tabBarItem
            return UINavigationController(rootViewController: controller)
        }
        setViewControllers(viewControllers, animated: false)
    }
    
}
