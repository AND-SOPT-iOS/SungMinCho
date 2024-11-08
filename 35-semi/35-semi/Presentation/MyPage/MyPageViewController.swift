//
//  MyPageViewController.swift
//  35-semi
//
//  Created by 조성민 on 11/8/24.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    private let apiService: APIService
    private let keyChainManager: KeyChainManager
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let hobbyLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var editButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "취미 변경"
        
        let button = UIButton(configuration: configuration)
        button.addTarget(
            self,
            action: #selector (editButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "로그아웃"
        
        let button = UIButton(configuration: configuration)
        button.addTarget(
            self,
            action: #selector(logoutButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var logoutAlertController: UIAlertController = {
        let alertController = UIAlertController(
            title: "로그아웃",
            message: "정말 로그아웃하시겠습니까?",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self else { return }
            keyChainManager.removeValue()
            UserDefaults.standard.removeObject(forKey: "id")
            UserDefaults.standard.removeObject(forKey: "password")
            
            navigationController?.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        return alertController
    }()
    
    private let editAlertController: UIAlertController = {
        let alertController = UIAlertController(
            title: "취미 변경",
            message: nil,
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        return alertController
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
        loadUserData()
    }
    
    override func setStyle() {
        view.backgroundColor = .systemBackground
    }
    
    override func setUI() {
        [
            usernameLabel,
            editButton,
            hobbyLabel,
            logoutButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        usernameLabel.snp.makeConstraints {
            $0.bottom.equalTo(hobbyLabel.snp.top).offset(-40)
            $0.centerX.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.equalTo(hobbyLabel)
            $0.leading.equalTo(hobbyLabel.snp.trailing).offset(40)
        }
        
        hobbyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(hobbyLabel.snp.bottom).offset(100)
        }
    }
    
    private func loadUserData() {
        apiService.fetchMyHobby { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let hobby):
                hobbyLabel.text = "취미 : \(hobby)"
                if let username = (UserDefaults.standard.string(forKey: "id")) {
                    usernameLabel.text = "이름 : \(username)"
                } else {
                    usernameLabel.text = "오류"
                }
            case .failure(let error):
                // TODO: Error Handling
                dump(error)
            }
        }
    }
    
    @objc private func editButtonTapped() {
        
    }
    
    @objc private func logoutButtonTapped() {
        present(logoutAlertController, animated: true)
    }
    
}
