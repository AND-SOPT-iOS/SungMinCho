//
//  AppView.swift
//  35-semi
//
//  Created by 조성민 on 10/31/24.
//

import UIKit

final class AppView: BaseView {
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        return imageView
    }()
    
    private let downloadStateButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setUI()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [
            titleStackView,
            rankLabel,
            iconImageView,
            downloadStateButton
        ].forEach {
            addSubview($0)
        }
        
        [
            titleLabel,
            subtitleLabel
        ].forEach {
            titleStackView.addArrangedSubview($0)
        }
    }
    
    override func setStyle() {
        
    }
    
    override func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        downloadStateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.greaterThanOrEqualTo(88)
        }
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.top.equalTo(titleStackView.snp.top)
        }
        
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(downloadStateButton.snp.leading)
        }
    }
}

extension AppView {

    func resetUI() {
        titleLabel.text = ""
        subtitleLabel.text = ""
        rankLabel.text = ""
        rankLabel.isHidden = false
        iconImageView.image = nil
        downloadStateButton.setImage(nil, for: .normal)
        downloadStateButton.configuration = nil
    }
    
    func updateUI(app: App) {
        titleLabel.text = app.title
        subtitleLabel.text = app.subtitle
        if let rank = app.rank {
            rankLabel.text = "\(rank)"
        } else {
            rankLabel.isHidden = true
        }
        iconImageView.image = UIImage(named: app.imageName)
        if app.downloadState == .reDownloadable {
            let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
            downloadStateButton.setImage(
                UIImage(
                    systemName: "icloud.and.arrow.down",
                    withConfiguration: imageConfiguration
                ),
                for: .normal
            )
        } else {
            var configuration = UIButton.Configuration.gray()
            configuration.baseForegroundColor = .tintColor
            downloadStateButton.configuration = configuration
            downloadStateButton.configuration?.cornerStyle = .capsule
            downloadStateButton.configuration?.title = app.downloadButtonTitle
        }
    }
    
}

#Preview
{
    let appView: AppView = {
        let appView = AppView()
        appView.updateUI(app: App.financialApps[0])
        return appView
    }()
    appView
}
