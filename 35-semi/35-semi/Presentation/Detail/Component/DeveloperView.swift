//
//  DeveloperView.swift
//  35-semi
//
//  Created by 조성민 on 10/19/24.
//

import UIKit

final class DeveloperView: BaseView {
    
    weak var delegate: DeveloperDelegate?
    
    private let developerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Developer"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .tintColor
        
        return label
    }()
    
    private let developerLabel: UILabel = {
        let label = UILabel()
        label.text = "개발자"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let chevronIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()

    init(developerName: String) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateUI(name: developerName)
        setTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI(name: String) {
        developerNameLabel.text = name
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        delegate?.developerTapped()
    }
    
    override func setUI() {
        [
            developerNameLabel,
            developerLabel,
            chevronIndicatorImageView
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        developerNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(snp.centerY)
        }
        
        developerLabel.snp.makeConstraints {
            $0.top.equalTo(developerNameLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        chevronIndicatorImageView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
    
}

protocol DeveloperDelegate: AnyObject {
    
    func developerTapped()
    
}

#Preview
{
    DeveloperView(developerName: "Viva Republica")
}
