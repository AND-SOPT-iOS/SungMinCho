//
//  MainViewController.swift
//  35-semi
//
//  Created by 조성민 on 11/1/24.
//

import UIKit

final class MainViewController: BaseViewController {

    private lazy var financeButton: UIButton = {
        let button = UIButton()
        button.setTitle("금융", for: .normal)
        button.addTarget(self, action: #selector(financeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }
    
    override func setStyle() {
        title = "앱"
        navigationItem.hidesBackButton = true
    }
    
    override func setUI() {
        view.addSubview(financeButton)
    }
    
    override func setLayout() {
        financeButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func financeButtonTapped() {
        navigationController?.pushViewController(FinanceViewController(), animated: true)
    }
    
}
