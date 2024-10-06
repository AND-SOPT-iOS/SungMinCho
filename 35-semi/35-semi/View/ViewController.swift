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
        button.layer.cornerRadius = 10
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
    
    private lazy var modeController: UISegmentedControl = {
        let controller = UISegmentedControl(items: ["푸시 모드", "모달 모드"])
        controller.selectedSegmentIndex = pushMode ? 0 : 1
        controller.addTarget(
            self,
            action: #selector(modeButtonTapped),
            for: .valueChanged
        )
        
        return controller
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
        [modeLabel, nextButton, modeController].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    func setLayout() {
        NSLayoutConstraint.activate(
            [
                modeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                modeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                modeController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                modeController.topAnchor.constraint(equalTo: modeLabel.bottomAnchor, constant: 50),
                modeController.heightAnchor.constraint(equalToConstant: 50),
                modeController.widthAnchor.constraint(equalToConstant: 300),
                nextButton.topAnchor.constraint(equalTo: modeController.bottomAnchor, constant: 50),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.heightAnchor.constraint(equalToConstant: 50),
                nextButton.widthAnchor.constraint(equalToConstant: 100)
            ]
        )
    }
    
}
