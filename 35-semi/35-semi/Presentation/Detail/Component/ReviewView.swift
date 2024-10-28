//
//  ReviewView.swift
//  35-semi
//
//  Created by 조성민 on 10/23/24.
//

import UIKit

final class ReviewView: BaseView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let developerHeaderView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        for i in 0..<5 {
            let starImageview = UIImageView()
            starImageview.snp.makeConstraints {
                $0.width.height.equalTo(16)
            }
            starImageview.tintColor = .orange
            stackView.addArrangedSubview(starImageview)
        }
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let writerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        
        return label
    }()
    
    private let contentLabelView = UIView()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        
        return label
    }()
    
    private let developerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let answerDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let answerContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var contentMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.textColor = .tintColor
        label.backgroundColor = .systemGray6
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(contentMoreLabelTapped))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let contentMoreLabelLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemGray6.withAlphaComponent(0).cgColor,
            UIColor.systemGray6.withAlphaComponent(1).cgColor,
            UIColor.systemGray6.withAlphaComponent(1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.addSublayer(gradientLayer)

        return view
    }()
    
    private let answerLabelView = UIView()
    
    private lazy var answerMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.textColor = .tintColor
        label.backgroundColor = .systemGray6
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(answerMoreLabelTapped))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let answerMoreLabelLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemGray6.withAlphaComponent(0).cgColor,
            UIColor.systemGray6.withAlphaComponent(1).cgColor,
            UIColor.systemGray6.withAlphaComponent(1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.addSublayer(gradientLayer)

        return view
    }()
    
    init(review: Review) {
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateUI(review: review)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        contentMoreLabelLeftView.layer.sublayers?.first?.frame = contentMoreLabelLeftView.bounds
        answerMoreLabelLeftView.layer.sublayers?.first?.frame = answerMoreLabelLeftView.bounds
    }
    
    private func updateUI(review: Review) {
        titleLabel.text = review.title
        dateLabel.text = review.writeDate.convertToString()
        writerLabel.text = review.writer
        contentLabel.text = review.content
        if review.developerAnswer != nil {
            developerLabel.text = "개발자 답변"
            answerDateLabel.text = review.devleoperAnswerDate?.convertToString()
            answerContentLabel.text = review.developerAnswer
        } else {
            developerHeaderView.removeFromSuperview()
            answerLabelView.removeFromSuperview()
            resizeContentView()
        }
        for i in 0..<5 {
            guard let imageView = starStackView.subviews[i] as? UIImageView else { return }
            if i < review.score.rawValue {
                imageView.image = UIImage(systemName: "star.fill")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
        if !contentLabel.isTruncated {
            contentMoreLabel.removeFromSuperview()
            contentMoreLabelLeftView.removeFromSuperview()
        }
        
        if !answerContentLabel.isTruncated {
            answerMoreLabel.removeFromSuperview()
            answerMoreLabelLeftView.removeFromSuperview()
        }
    }
    
    @objc func contentMoreLabelTapped() {
        contentLabel.numberOfLines = 0
        contentMoreLabel.removeFromSuperview()
        contentMoreLabelLeftView.removeFromSuperview()
    }
    
    @objc func answerMoreLabelTapped() {
        answerContentLabel.numberOfLines = 0
        answerMoreLabel.removeFromSuperview()
        answerMoreLabelLeftView.removeFromSuperview()
    }

    override func setStyle() {
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
    }
    
    override func setUI() {
        [
            titleLabel,
            starStackView,
            dateLabel,
            writerLabel
        ].forEach {
            headerView.addSubview($0)
        }
        [
            developerLabel,
            answerDateLabel
        ].forEach {
            developerHeaderView.addSubview($0)
        }
        stackView.addArrangedSubview(contentView)
        [
            headerView,
            contentLabelView,
            developerHeaderView,
            answerLabelView
        ].forEach {
            contentView.addSubview($0)
        }
        [
            answerContentLabel,
            answerMoreLabel,
            answerMoreLabelLeftView
        ].forEach {
            answerLabelView.addSubview($0)
        }
        [
            contentLabel,
            contentMoreLabel,
            contentMoreLabelLeftView
        ].forEach {
            contentLabelView.addSubview($0)
        }
        addSubview(stackView)
    }
    
    override func setLayout() {
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(stackView)
        }
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(40)
        }
        
        contentLabelView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(contentView).inset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.edges.equalTo(contentLabelView)
        }
        
        contentMoreLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(contentLabelView)
        }
        
        contentMoreLabelLeftView.snp.makeConstraints {
            $0.trailing.equalTo(contentMoreLabel.snp.leading)
            $0.bottom.equalTo(contentMoreLabel.snp.bottom)
            $0.width.equalTo(40)
            $0.height.equalTo(contentMoreLabel.snp.height)
        }
        
        developerHeaderView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(10)
        }
        
        answerLabelView.snp.makeConstraints {
            $0.top.equalTo(developerHeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(contentView).inset(20)
        }
        
        answerContentLabel.snp.makeConstraints {
            $0.edges.equalTo(answerLabelView)
        }
        
        answerMoreLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(answerLabelView)
        }
        
        answerMoreLabelLeftView.snp.makeConstraints {
            $0.trailing.equalTo(answerMoreLabel.snp.leading)
            $0.bottom.equalTo(answerMoreLabel.snp.bottom)
            $0.width.equalTo(40)
            $0.height.equalTo(answerMoreLabel.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(headerView)
        }
        
        starStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(headerView)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(headerView)
        }
        
        writerLabel.snp.makeConstraints {
            $0.centerY.equalTo(starStackView)
            $0.trailing.equalTo(headerView)
        }
        
        developerLabel.snp.makeConstraints {
            $0.top.equalTo(developerHeaderView)
            $0.leading.equalTo(developerHeaderView)
        }
        
        answerDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(developerLabel)
            $0.trailing.equalTo(developerHeaderView)
        }
        resizeContentView()
    }
    
    private func resizeContentView() {
        if let lastView = contentView.subviews.last {
            contentView.snp.makeConstraints {
                $0.bottom.equalTo(lastView.snp.bottom).offset(20)
            }
        }
    }
    
}

#Preview
{
    ReviewView(
        review: Review(
            writer: "조성민",
            writeDate: Date(),
            title: "폰트 크기 복구해주세요.....",
            score: Score.four,
            content: """
오늘 토스가 어쩌구 저쩌구 오늘 토스가
어쩌구 저쩌구 오늘 토스가 어쩌구 저쩌구 오늘 토스가 어쩌구
저쩌구 오늘 토스가 어쩌구 저쩌구 오늘 토스가 어쩌구 저쩌구
오늘 토스가 어쩌구 저쩌구 오늘 토스가 어쩌구 저쩌구 오늘
""",
            developerAnswer: "ABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABC",
            devleoperAnswerDate: Date()
        )
    )
}
