//
//  PreviewScreenshotView.swift
//  35-semi
//
//  Created by 조성민 on 10/17/24.
//

import UIKit

final class PreviewScreenshotView: BaseView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        imageView.image = .cat
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "미리보기"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let deviceIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "iphone.gen3")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()
    
    private let deviceLabel: UILabel = {
        let label = UILabel()
        label.text = "iPhone"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [
            titleLabel,
            imageView,
            deviceIcon,
            deviceLabel
        ].forEach {
            addSubview(
                $0
            )
        }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(400)
        }
        
        deviceIcon.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        deviceLabel.snp.makeConstraints {
            $0.centerY.equalTo(deviceIcon.snp.centerY)
            $0.leading.equalTo(deviceIcon.snp.trailing).offset(10)
        }
    }
    
}

#Preview
{
    PreviewScreenshotView()
}
