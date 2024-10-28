//
//  MainViewController.swift
//  35-semi
//
//  Created by 조성민 on 10/5/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Toss 상세화면 보기", for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 10
        button.setTitleColor(
            .label,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(nextButtonTapped), for: .touchUpInside
        )
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override func setStyle() {
        self.view.backgroundColor = .systemBackground
    }
    
    override func setUI() {
        [nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate(
            [
                nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.heightAnchor.constraint(equalToConstant: 50),
                nextButton.widthAnchor.constraint(equalToConstant: 200)
            ]
        )
    }
    
    @objc
    func nextButtonTapped() {
        let nextViewController = ChartViewController()
        self.navigationController?.pushViewController(
            nextViewController,
            animated: true
        )
    }
    
}
