//
//  ReviewDistributionBar.swift
//  35-semi
//
//  Created by 조성민 on 10/21/24.
//

import UIKit

final class ReviewDistributionBar: BaseView {
    
    private let starImageStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private let barBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryLabel
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    init(score: Score, ratio: Double) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateUI(score: score, ratio: ratio)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI(score: Score, ratio: Double) {
        for i in 0..<5 {
            let imageView = UIImageView(image: .init(systemName: "star.fill"))
            imageView.tintColor = .secondaryLabel
            imageView.snp.makeConstraints {
                $0.width.height.equalTo(10)
            }
            starImageStackView.addArrangedSubview(imageView)
            if i < 5 - score.rawValue {
                imageView.alpha = 0
            }
        }
        barView.snp.makeConstraints {
            $0.width.equalTo(barBackgroundView).multipliedBy(ratio)
            $0.height.equalTo(4)
        }
    }
    
    override func setUI() {
        [
            starImageStackView,
            barBackgroundView,
            barView
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        starImageStackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        barBackgroundView.snp.makeConstraints {
            $0.centerY.equalTo(starImageStackView)
            $0.leading.equalTo(starImageStackView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(4)
        }
        barView.snp.makeConstraints {
            $0.centerY.equalTo(starImageStackView)
            $0.leading.equalTo(starImageStackView.snp.trailing).offset(10)
            $0.height.equalTo(4)
        }
    }
    
}

#Preview
{
    ReviewDistributionBar(score: .four, ratio: 0.7)
}
