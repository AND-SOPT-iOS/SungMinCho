//
//  ReviewView.swift
//  35-semi
//
//  Created by 조성민 on 10/23/24.
//

import UIKit

final class ReviewView: BaseView {
    
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
    
    init() {
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
        
        contentMoreLabelLeftView.layer.sublayers?.first?.frame = contentMoreLabelLeftView.bounds
        answerMoreLabelLeftView.layer.sublayers?.first?.frame = answerMoreLabelLeftView.bounds
        
        if !contentLabel.isTruncated {
            contentMoreLabel.isHidden = true
            contentMoreLabelLeftView.isHidden = true
        }
        
        if !answerContentLabel.isTruncated {
            answerMoreLabel.isHidden = true
            answerMoreLabelLeftView.isHidden = true
        }
    }
    
    func resetUI() {
        titleLabel.text = ""
        dateLabel.text = ""
        writerLabel.text = ""
        contentLabel.text = ""
        contentMoreLabel.isHidden = false
        contentMoreLabelLeftView.isHidden = false
        answerMoreLabel.isHidden = false
        answerMoreLabelLeftView.isHidden = false
        
        for i in 0..<5 {
            guard let imageView = starStackView.subviews[i] as? UIImageView else { return }
            imageView.image = UIImage(systemName: "star")
        }
    }
    
    func updateUI(review: Review) {
        titleLabel.text = review.title
        dateLabel.text = review.writeDate.convertToString()
        writerLabel.text = review.writer
        contentLabel.text = review.content
        if review.developerAnswer != nil {
            developerLabel.text = "개발자 답변"
            answerDateLabel.text = review.devleoperAnswerDate?.convertToString()
            answerContentLabel.text = review.developerAnswer
                snp.makeConstraints {
                $0.top.leading.trailing.equalTo(self)
                $0.bottom.equalTo(answerContentLabel.snp.bottom).offset(20)
            }
        } else {
            snp.makeConstraints {
                $0.top.leading.trailing.equalTo(self)
                $0.bottom.equalTo(contentLabel.snp.bottom).offset(20)
            }
        }
        for i in 0..<5 {
            guard let imageView = starStackView.subviews[i] as? UIImageView else { return }
            if i < review.score.rawValue {
                imageView.image = UIImage(systemName: "star.fill")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
        
    }
    
    @objc func contentMoreLabelTapped() {
        // TODO: delegate로 ViewController Push
    }
    
    @objc func answerMoreLabelTapped() {
        // TODO: delegate로 ViewController Push
    }
    
    override func setStyle() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    override func setUI() {
        [
            titleLabel,
            dateLabel,
            starStackView,
            writerLabel,
            contentLabel,
            contentMoreLabel,
            contentMoreLabelLeftView,
            developerLabel,
            answerDateLabel,
            answerContentLabel,
            answerMoreLabel,
            answerMoreLabelLeftView
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        dateLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
        }
        starStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.trailing.equalTo(dateLabel)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(starStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        contentMoreLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(contentLabel)
        }
        contentMoreLabelLeftView.snp.makeConstraints {
            $0.trailing.equalTo(contentMoreLabel.snp.leading)
            $0.bottom.equalTo(contentLabel)
            $0.width.equalTo(40)
            $0.height.equalTo(contentMoreLabel)
        }
        developerLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        answerDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        answerContentLabel.snp.makeConstraints {
            $0.top.equalTo(developerLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        answerMoreLabel.snp.makeConstraints {
            $0.bottom.trailing.equalTo(answerContentLabel)
        }
        answerMoreLabelLeftView.snp.makeConstraints {
            $0.trailing.equalTo(answerMoreLabel.snp.leading)
            $0.bottom.equalTo(answerContentLabel.snp.bottom)
            $0.width.equalTo(40)
            $0.height.equalTo(answerMoreLabel)
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
            content: "오늘 토스가 어쩌구 저쩌구 오늘 토스가 오늘 토스가 어쩌구 저쩌구 오늘 토스가 오늘 토스가 어쩌구 저쩌구 오늘 토스가 오늘 토스가 어쩌구 저쩌구",
            developerAnswer: "ABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABCABC",
            devleoperAnswerDate: Date()
        )
    )
}
