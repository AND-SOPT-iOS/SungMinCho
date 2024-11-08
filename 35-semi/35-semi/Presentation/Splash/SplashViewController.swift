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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "고양이 스플래시 🐈‍⬛"
        label.font = .systemFont(ofSize: .init(30), weight: .bold)
        label.textColor = .systemPink
        
        return label
    }()
    
    private let splashImageView: UIImageView = {
        let imageView = UIImageView(image: .cat3)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .systemBlue
        
        return imageView
    }()
    
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
    
    override func setUI() {
        [
            titleLabel,
            splashImageView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        splashImageView.snp.makeConstraints {
            $0.width.height.equalTo(300)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(splashImageView.snp.top).offset(-40)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func checkAutoLogin() {
        sleep(3)
        keyChainManager.removeValue()
        if let id = UserDefaults.standard.string(forKey: "id"),
           let password = UserDefaults.standard.string(forKey: "password") {
            apiService.login(username: id, password: password) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    let tabBarViewController = TabBarViewController(apiService: apiService)
                    present(tabBarViewController, animated: false)
                case .failure:
                    UserDefaults.standard.removeObject(forKey: "id")
                    UserDefaults.standard.removeObject(forKey: "password")
                    let loginViewController = LoginViewController(apiService: apiService)
                    present(loginViewController, animated: false)
                }
            }
        } else {
            let loginViewController = LoginViewController(apiService: apiService)
            present(loginViewController, animated: false)
        }
    }
    
}
