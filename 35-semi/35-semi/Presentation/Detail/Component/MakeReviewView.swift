//
//  MakeReviewView.swift
//  35-semi
//
//  Created by 조성민 on 10/23/24.
//

import UIKit

final class MakeReviewView: BaseView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "탭하여 평가하기:"
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var starButtonList: [UIButton] = {
        var buttonList: [UIButton] = []
        let buttonSize: CGFloat = 16
        var imageConfig = UIImage.SymbolConfiguration(pointSize: buttonSize)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "star")
        configuration.baseBackgroundColor = .systemBackground
        configuration.preferredSymbolConfigurationForImage = imageConfig
        var configurationHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                button.configuration?.image = UIImage(systemName: "star.fill")
            case .normal:
                button.configuration?.image = UIImage(systemName: "star")
            default:
                break
            }
        }
        
        for i in 0..<5 {
            let button = UIButton(configuration: configuration)
            button.configurationUpdateHandler = configurationHandler
            
            button.tag = i
            button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.width.height.equalTo(buttonSize)
            }
            buttonList.append(button)
        }
        return buttonList
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        
        return stackView
    }()
    
    private lazy var reviewView: ReviewView = {
        let view = ReviewView(review: bestReview)
        
        return view
    }()
    
    private let writeReviewButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "리뷰 작성"
        configuration.image = UIImage(systemName: "square.and.pencil")
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let applicationSupportButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "앱 지원"
        configuration.image = UIImage(systemName: "questionmark.circle")
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let bestReview: Review
    
    init(bestReview: Review) {
        self.bestReview = bestReview
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        starButtonList.enumerated().forEach { (i, button) in
            button.isSelected = i <= index
        }
    }
    
    override func setUI() {
        starButtonList.forEach {
            starStackView.addArrangedSubview($0)
        }
        
        [
            headerLabel,
            starStackView,
            reviewView,
            writeReviewButton,
            applicationSupportButton
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        starStackView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(starStackView)
        }
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        writeReviewButton.snp.makeConstraints {
            $0.top.equalTo(reviewView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        
        applicationSupportButton.snp.makeConstraints {
            $0.top.equalTo(reviewView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview()
        }
    }
    
}

#Preview
{
    MakeReviewView(
        bestReview: Review(
            writer: "조성민",
            writeDate: Date(),
            title: "폰트 크기 복구해주세요.....",
            score: Score.four,
            content: "ABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABC",
            developerAnswer: "그랬구나~",
            devleoperAnswerDate: Date()
        )
    )
}
