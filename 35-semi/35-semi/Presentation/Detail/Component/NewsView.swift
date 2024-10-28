//
//  NewsView.swift
//  35-semi
//
//  Created by 조성민 on 10/17/24.
//

import UIKit

final class NewsView: BaseView {

    weak var delegate: NewsDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 소식"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var navigationButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "버전 기록"
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
        
        return label
    }()
    
    init(version: String, news: String, updateDate: Date) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateView(
            version: version,
            news: news,
            updateDate: updateDate
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func navigationButtonTapped() {
        delegate?.navigateToRecordViewController()
    }
    
    private func updateView(version: String, news: String, updateDate: Date) {
        versionLabel.text = "버전 " + version
        newsLabel.setLineSpacingText(text: news, spacing: 8)
        dateLabel.text = updateDate.convertFromNow()
    }
    
    override func setUI() {
        [
            titleLabel,
            versionLabel,
            navigationButton,
            dateLabel,
            newsLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        versionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        navigationButton.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(navigationButton.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
        }
        
        newsLabel.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}

protocol NewsDelegate: AnyObject {
    
    func navigateToRecordViewController()
    
}

#Preview
{
    NewsView(
        version: "5.183.0",
        news: "- 구석구석 숨어있던 버그들을 잡았어요. 또 다른 버그가 나타나면 토스 고객센터를 찾아주세요. 늘 열려있답니다. 365일 24시간 언제든지요.",
        updateDate: Date(
            year: 2024,
            month: 10,
            day: 17,
            hour: 13,
            minute: 31
        )
    )
}
