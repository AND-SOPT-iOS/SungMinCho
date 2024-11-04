//
//  FinanceMainCollectionViewCell.swift
//  35-semi
//
//  Created by 조성민 on 10/31/24.
//

import UIKit

final class FinanceMainCollectionViewCell: BaseCollectionViewCell {
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tintColor
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.withAlphaComponent(0).cgColor,
            UIColor.clear.withAlphaComponent(0.4).cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.addSublayer(gradientLayer)
        
        return view
    }()
    
    private let appView: AppView = {
        let view = AppView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        blurView.layer.sublayers?.last?.frame = appView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    override func setUI() {
        [
            typeLabel,
            titleLabel,
            subtitleLabel,
            thumbnailImageView,
            blurView,
            appView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setLayout() {
        typeLabel.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(contentView)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(contentView)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(260)
        }
        
        blurView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(thumbnailImageView)
            $0.height.equalTo(70)
        }
        
        appView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(thumbnailImageView)
            $0.height.equalTo(70)
        }
    }
    
    private func resetUI() {
        typeLabel.text = ""
        titleLabel.text = ""
        subtitleLabel.text = ""
        thumbnailImageView.image = nil
        appView.resetUI()
    }
    
    func configure(model: FinanceMainCellModel) {
        typeLabel.text = model.type.rawValue
        titleLabel.text = model.app.title
        subtitleLabel.text = model.subtitle
        thumbnailImageView.image = UIImage(named: model.thumbnailImageName)
        appView.updateUI(app: model.app)
    }
    
}

#Preview
{
    let cell: FinanceMainCollectionViewCell = {
        let cell = FinanceMainCollectionViewCell()
        cell.configure(model: FinanceMainCellModel.mockModels[3])
        cell.snp.makeConstraints {
            $0.width.height.equalTo(400)
        }
        return cell
    }()
    cell
}
