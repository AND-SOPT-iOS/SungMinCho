//
//  AwardSummaryView.swift
//  35-semi
//
//  Created by 조성민 on 10/16/24.
//

import UIKit

final class AwardSummaryView: BaseView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let awardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    init(award: Award) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateUI(award: award)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI(award: Award) {
        switch award {
        case .editorChoice:
            titleLabel.text = "수상"
            awardImageView.image = UIImage(systemName: "person")
            typeLabel.text = "앱"
        }
    }
    
    override func setUI() {
        [
            titleLabel,
            awardImageView,
            typeLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(snp.centerX)
            $0.top.equalTo(snp.top)
        }
        
        awardImageView.snp.makeConstraints {
            $0.centerX.equalTo(snp.centerX)
            $0.centerY.equalTo(snp.centerY)
        }
        
        typeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

#Preview
{
    AwardSummaryView(award: .editorChoice)
}
