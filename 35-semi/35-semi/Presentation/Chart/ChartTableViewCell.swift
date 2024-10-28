//
//  ChartTableViewCell.swift
//  35-semi
//
//  Created by 조성민 on 10/26/24.
//

import UIKit

final class ChartTableViewCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func resetUI() {
        titleLabel.text = ""
        subtitleLabel.text = ""
        rankLabel.text = ""
        iconImageView.image = nil
        downloadStateButton.configuration = nil
        downloadStateButton.setImage(nil, for: .normal)
    }
    
    private func setUI() {
        [
            titleStackView,
            rankLabel,
            iconImageView,
            downloadStateButton
        ].forEach {
            contentView.addSubview($0)
        }
        [
            titleLabel,
            subtitleLabel
        ].forEach {
            titleStackView.addArrangedSubview($0)
        }
    }
    
    private func setStyle() {
        selectionStyle = .none
    }
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        downloadStateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(88)
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
    
    func configure(app: App) {
        titleLabel.text = app.title
        subtitleLabel.text = app.subtitle
        rankLabel.text = "\(app.rank)"
        iconImageView.image = UIImage(named: app.imageName)
        if app.downloadState == .reDownloadable {
            let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
            downloadStateButton
                .setImage(
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
            downloadStateButton.configuration?.title = app.downloadState.downloadButtonTitle
        }
    }
    
}

#Preview
{
    let cell1: ChartTableViewCell = {
        let cell = ChartTableViewCell(style: .default, reuseIdentifier: nil)
        cell.snp.makeConstraints {
            $0.width.equalTo(400)
            $0.height.equalTo(92)
        }
        cell.configure(app: App.sampleApps[3])
        return cell
    }()
    cell1
}
