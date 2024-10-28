//
//  AppCardView.swift
//  35-semi
//
//  Created by 조성민 on 10/15/24.
//

import UIKit

final class AppCardView: BaseView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        
        return label
    }()
    
    private let openButton: UIButton = {
        var attributedString = AttributedString("열기")
        attributedString.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = attributedString
        configuration.baseBackgroundColor = .tintColor
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let shareButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        configuration.baseForegroundColor = .tintColor
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    init(image: UIImage, title: String, subtitle: String) {
        super.init(frame: .zero)
        
        self.imageView.image = image
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [
            imageView,
            titleLabel,
            subtitleLabel,
            openButton,
            shareButton
        ].forEach {
            self.addSubview($0)
        }
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        openButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(80)
            $0.height.equalTo(34)
        }
        
        shareButton.snp.makeConstraints {
            $0.centerY.equalTo(openButton.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(openButton.snp.height)
        }
    }
    
}

#Preview
{
    AppCardView(image: .toss, title: "토스", subtitle: "금융이 쉬워진다")
}
