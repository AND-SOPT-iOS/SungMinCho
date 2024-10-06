//
//  ViewController.swift
//  35-semi
//
//  Created by 조성민 on 10/5/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let modeLabel: UILabel = {
        let label = UILabel()
        label.text = "푸시 모드"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private var pushMode: Bool = true
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(nextButtonTapped), for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var modeButton: UIButton = {
        let button = UIButton()
        button.setTitle("모드 변경", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(modeButtonTapped), for: .touchUpInside
        )
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }
    
}

@objc
extension ViewController {
    
    func modeButtonTapped() {
        pushMode.toggle()
        modeLabel.text = pushMode ? "푸시 모드" : "모달 모드"
    }
    
    func nextButtonTapped() {
        let nextViewController = DetailViewController()
        if pushMode {
            nextViewController.dataBind(
                title: "Push 모드",
                content: "Push 뷰컨"
            )
            self.navigationController?.pushViewController(
                nextViewController,
                animated: true
            )
        } else {
            nextViewController.dataBind(
                title: "Modal 모드",
                content: "Modal 뷰컨"
            )
            self.present(nextViewController, animated: true)
        }
    }
    
}

private extension ViewController {
    
    func setStyle() {
        self.view.backgroundColor = .white
    }
    
    func setUI() {
        [modeLabel, nextButton, modeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    func setLayout() {
        NSLayoutConstraint.activate(
            [
                modeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                modeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                modeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                modeButton.topAnchor.constraint(equalTo: modeLabel.bottomAnchor, constant: 50),
                modeButton.heightAnchor.constraint(equalToConstant: 50),
                modeButton.widthAnchor.constraint(equalToConstant: 100),
                nextButton.topAnchor.constraint(equalTo: modeButton.bottomAnchor, constant: 50),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.heightAnchor.constraint(equalToConstant: 50),
                nextButton.widthAnchor.constraint(equalToConstant: 100)
            ]
        )
    }
    
}
