//
//  EvaluationWithReviewView.swift
//  35-semi
//
//  Created by 조성민 on 10/19/24.
//

import UIKit

final class EvaluationWithReviewView: BaseView {
    
    weak var delegate: EvaluationWithReviewViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "평가 및 리뷰"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.contentVerticalAlignment = .bottom
        button.addTarget(self, action: #selector(showAllButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 70, weight: .bold)
        
        return label
    }()
    
    private let scoreSubLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .secondaryLabel
        label.text = "5점 만점"
        
        return label
    }()
    
    private let reviewDistributionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let evaluationCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    init(reviewDistribution: ReviewDistribution) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateUI(reviewDistribution: reviewDistribution)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI(reviewDistribution: ReviewDistribution) {
        scoreLabel.text = "\(reviewDistribution.averageScore)"
        
        Score.allCases.forEach { score in
            let bar = ReviewDistributionBar(
                score: score,
                ratio: reviewDistribution.getRatio(score: score)
            )
            bar.snp.makeConstraints {
                $0.height.equalTo(6)
            }
            reviewDistributionStackView.addArrangedSubview(bar)
        }
        
        evaluationCountLabel.text = "\(reviewDistribution.translatedTotalCountString)개의 리뷰"
    }
    
    @objc func showAllButtonTapped() {
        delegate?.showAllButtonTapped()
    }
    
    override func setUI() {
        [
            titleLabel,
            showAllButton,
            scoreLabel,
            scoreSubLabel,
            reviewDistributionStackView,
            evaluationCountLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        showAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        scoreSubLabel.snp.makeConstraints {
            $0.centerX.equalTo(scoreLabel)
            $0.top.equalTo(scoreLabel.snp.bottom)
        }
        
        reviewDistributionStackView.snp.makeConstraints {
            $0.leading.equalTo(scoreLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(scoreLabel.snp.centerY)
            $0.trailing.equalToSuperview()
        }
        
        evaluationCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(scoreSubLabel)
        }
    }
    
}

protocol EvaluationWithReviewViewDelegate: AnyObject {
    
    func showAllButtonTapped()
    
}

#Preview
{
    EvaluationWithReviewView(
        reviewDistribution: ReviewDistribution(
            five: 58800,
            four: 10920,
            three: 2520,
            two: 840,
            one: 10920
        )
    )
}
