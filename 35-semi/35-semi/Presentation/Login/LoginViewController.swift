//
//  LoginViewController.swift
//  35-semi
//
//  Created by 조성민 on 11/4/24.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    private let apiService: APIService
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.setStyle()
        textField.placeholder = "아이디"
        textField.delegate = self
        textField.addTarget(
            self,
            action: #selector(idTextFieldChanged),
            for: .editingChanged
        )
        
        return textField
    }()
    
    private let idWarningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "아이디를 입력해주세요."
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setStyle()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(
            self,
            action: #selector(passwordTextFieldChanged),
            for: .editingChanged
        )
        
        return textField
    }()
    
    private let passwordWarningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "비밀번호를 입력해주세요."
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "로그인"
        
        let button = UIButton(configuration: configuration)
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "회원가입"
        
        let button = UIButton(configuration: configuration)
        button.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    init(apiService: APIService) {
        self.apiService = apiService
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
    
    override func setStyle() {
        view.backgroundColor = .systemBackground
    }
    
    override func setUI() {
        [
            idTextField,
            idWarningLabel,
            passwordTextField,
            passwordWarningLabel,
            loginButton,
            signUpButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        
        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-150)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        idWarningLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(2)
            $0.leading.equalTo(idTextField).offset(4)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idWarningLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(2)
            $0.leading.equalTo(passwordTextField).offset(4)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordWarningLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(60)
        }
    }
    
    @objc private func loginButtonTapped() {
        let id = idTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if id.isEmpty == false && password.isEmpty == false {
            login(id: id, password: password)
        } else {
            if id.isEmpty {
                idWarningLabel.isHidden = false
            }
            if password.isEmpty {
                passwordWarningLabel.isHidden = false
            }
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(
            signUpViewController,
            animated: true
        )
    }
    
    @objc private func idTextFieldChanged() {
        idWarningLabel.isHidden = true
    }
    
    @objc private func passwordTextFieldChanged() {
        passwordWarningLabel.isHidden = true
    }
    
    private func login(id: String, password: String) {
        apiService.login(username: id, password: password) { result in
            switch result {
            case .success(let token):
                print(token)
                // TODO: 토큰 저장
            case .failure(let failure):
                dump(failure)
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 8
    }
    
}

#Preview
{
    LoginViewController(apiService: APIService())
}
