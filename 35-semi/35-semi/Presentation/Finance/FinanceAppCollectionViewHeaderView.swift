//
//  FinanceAppCollectionViewHeaderView.swift
//  35-semi
//
//  Created by 조성민 on 11/1/24.
//

import UIKit

final class FinanceAppCollectionViewHeaderView: UICollectionReusableView {
    
    weak var delegate: FinanceAppCollectionViewHeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.addTarget(self, action: #selector(showAllButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var viewType: HeaderViewType?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        subtitleLabel.text = ""
        viewType = nil
    }
    
    private func setUI() {
        [
            titleLabel,
            subtitleLabel,
            showAllButton
        ].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(subtitleLabel.snp.top)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        showAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
        }
    }
    
    @objc private func showAllButtonTapped() {
        if viewType == .free {
            delegate?.showAllButtonTapped()
        }
    }
    
    func configure(title: String, subtitle: String? = nil, viewType: HeaderViewType) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        self.viewType = viewType
    }
    
}

protocol FinanceAppCollectionViewHeaderViewDelegate: AnyObject {
    
    func showAllButtonTapped()
    
}
