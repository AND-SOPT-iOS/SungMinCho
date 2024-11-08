//
//  SignUpViewController.swift
//  35-semi
//
//  Created by 조성민 on 11/4/24.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    private let apiService: APIService
    
    private let idHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.setStyle()
        textField.placeholder = "1~8 글자수"
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
    
    private let passwordHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setStyle()
        textField.placeholder = "1~8 글자수"
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
    
    
    private let passwordValidationHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private lazy var passwordValidationTextField: UITextField = {
        let textField = UITextField()
        textField.setStyle()
        textField.placeholder = "1~8 글자수"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(
            self,
            action: #selector(passwordValidationTextFieldChanged),
            for: .editingChanged
        )
        
        return textField
    }()
    
    private let passwordValidationWarningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "비밀번호를 입력해주세요."
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    private let hobbyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "취미"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private lazy var hobbyTextField: UITextField = {
        let textField = UITextField()
        textField.setStyle()
        textField.placeholder = "1~8 글자수"
        textField.delegate = self
        textField.addTarget(
            self,
            action: #selector(hobbyTextFieldChanged),
            for: .editingChanged
        )
        
        return textField
    }()
    
    private let hobbyWarningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "취미를 입력해주세요."
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "회원가입"
        
        let button = UIButton(configuration: configuration)
        button.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var signUpSuccessAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "회원가입 완료",
            message: nil,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        
        return alert
    }()
    
    private lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "오류",
            message: "알 수 없는 오류가 발생했습니다.",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        
        return alert
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
    }
    
    override func setStyle() {
        view.backgroundColor = .systemBackground
    }
    
    override func setUI() {
        [
            idHeaderLabel,
            idTextField,
            idWarningLabel,
            passwordHeaderLabel,
            passwordTextField,
            passwordWarningLabel,
            passwordValidationHeaderLabel,
            passwordValidationTextField,
            passwordValidationWarningLabel,
            signUpButton,
            hobbyHeaderLabel,
            hobbyTextField,
            hobbyWarningLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(140)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        idHeaderLabel.snp.makeConstraints {
            $0.leading.equalTo(idTextField).offset(4)
            $0.bottom.equalTo(idTextField.snp.top).offset(-4)
        }
        
        idWarningLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(2)
            $0.leading.equalTo(idTextField).offset(4)
        }
        
        passwordHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(idWarningLabel.snp.bottom).offset(8)
            $0.leading.equalTo(idWarningLabel)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordHeaderLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(2)
            $0.leading.equalTo(passwordTextField).offset(4)
        }
        
        passwordValidationHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(passwordWarningLabel.snp.bottom).offset(8)
            $0.leading.equalTo(passwordWarningLabel)
        }
        
        passwordValidationTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordValidationHeaderLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        passwordValidationWarningLabel.snp.makeConstraints {
            $0.top.equalTo(passwordValidationTextField.snp.bottom).offset(2)
            $0.leading.equalTo(passwordValidationTextField).offset(4)
        }
        
        hobbyHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(passwordValidationWarningLabel.snp.bottom).offset(8)
            $0.leading.equalTo(passwordValidationWarningLabel)
        }
        
        hobbyTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(hobbyHeaderLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        hobbyWarningLabel.snp.makeConstraints {
            $0.top.equalTo(hobbyTextField.snp.bottom).offset(2)
            $0.leading.equalTo(hobbyTextField).offset(4)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(hobbyWarningLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func idTextFieldChanged() {
        idWarningLabel.isHidden = true
    }
    
    @objc private func passwordTextFieldChanged() {
        passwordWarningLabel.isHidden = true
    }
    
    @objc private func passwordValidationTextFieldChanged() {
        if passwordValidationTextField.text?.isEmpty == false {
            passwordValidationWarningLabel.text = "비밀번호가 일치하지 않습니다."
        } else {
            passwordValidationWarningLabel.text = "비밀번호를 입력해주세요."
        }
        passwordValidationWarningLabel.isHidden = true
    }
    
    @objc private func hobbyTextFieldChanged() {
        hobbyWarningLabel.isHidden = true
    }
    
    @objc private func signUpButtonTapped() {
        let id = idTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordValidation = passwordValidationTextField.text ?? ""
        let hobby = hobbyTextField.text ?? ""
        
        if id.isEmpty == false
            && password.isEmpty == false
            && password == passwordValidation
            && hobby.isEmpty == false {
            idWarningLabel.isHidden = true
            passwordWarningLabel.isHidden = true
            passwordValidationWarningLabel.isHidden = true
            hobbyWarningLabel.isHidden = true
            signUp(id: id, password: password, hobby: hobby)
        } else {
            if id.isEmpty != false {
                idWarningLabel.isHidden = false
            }
            if password.isEmpty != false {
                passwordWarningLabel.isHidden = false
            }
            if password != passwordValidation || passwordValidation.isEmpty != false {
                passwordValidationWarningLabel.isHidden = false
            } else {
                passwordValidationWarningLabel.isHidden = true
            }
            if hobby.isEmpty != false {
                hobbyWarningLabel.isHidden = false
            }
        }
    }
    
    private func signUp(id: String, password: String, hobby: String) {
        apiService.register(username: id, password: password, hobby: hobby) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                present(signUpSuccessAlert, animated: true)
            case .failure:
                present(errorAlert, animated: true)
            }
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
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
