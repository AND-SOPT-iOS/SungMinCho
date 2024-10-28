//
//  ExplanationView.swift
//  35-semi
//
//  Created by 조성민 on 10/18/24.
//

import UIKit

final class ExplanationView: BaseView {
    
    private lazy var tapGestrue = UITapGestureRecognizer(
        target: self,
        action: #selector(
            explanationLabelTapped
        )
    )
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGestrue)
        
        return label
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.textColor = .tintColor
        label.backgroundColor = .systemBackground
        
        return label
    }()
    
    private let moreLabelLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemBackground.withAlphaComponent(0).cgColor,
            UIColor.systemBackground.withAlphaComponent(1).cgColor,
            UIColor.systemBackground.withAlphaComponent(1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.addSublayer(gradientLayer)

        return view
    }()
    
    private let originalExplanation: String
    
    init(explanation: String) {
        self.originalExplanation = explanation
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
        updateUI(explanation: explanation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        moreLabelLeftView.layer.sublayers?.first?.frame = moreLabelLeftView.bounds
    }
    
    @objc func explanationLabelTapped() {
        explanationLabel.numberOfLines = 0
        explanationLabel.removeGestureRecognizer(tapGestrue)
        moreLabel.removeFromSuperview()
        moreLabelLeftView.removeFromSuperview()
        explanationLabel.setLineSpacingText(text: originalExplanation, spacing: 8)
    }
    
    private func updateUI(explanation: String) {
        var trimmedExplanation = explanation
        while trimmedExplanation.contains("\n\n") {
            trimmedExplanation = trimmedExplanation.replacingOccurrences(of: "\n\n", with: "\n")
        }
        explanationLabel.setLineSpacingText(text: trimmedExplanation, spacing: 8)
        if !explanationLabel.isTruncated {
            explanationLabel.numberOfLines = 0
            explanationLabel.removeGestureRecognizer(tapGestrue)
            moreLabel.removeFromSuperview()
            moreLabelLeftView.removeFromSuperview()
            explanationLabel.setLineSpacingText(text: originalExplanation, spacing: 8)
        }
    }
    
    override func setUI() {
        [
            explanationLabel,
            moreLabel,
            moreLabelLeftView
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        explanationLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        moreLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
        }
        
        moreLabelLeftView.snp.makeConstraints {
            $0.trailing.equalTo(moreLabel.snp.leading)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(moreLabel.snp.height)
        }
    }
    
}

#Preview
{
    ExplanationView(explanation: """
토스뱅크, 토스증권 서비스를 이용하시려면 토스 앱 설치가 필요합니다.• 모든 계좌의 모든 정보를 한 곳에서, 따로 보았던 예적금, 청약, 증권, 대출 계좌의 정보를 한 곳에서 확인할 수 있어요.• 

얼마나 벌고 얼마나 썼을까? 한 달 동안의 수입과 소비를 시간 순으로 모아볼 수 있고, 소비 분석 리포트도 제공해드려요.

• 카드 실적 헷갈릴 필요 없이, 실적을 충족한 카드가 무엇인지 얼마나 더 써야 실적을 달성하는지 한눈에 확인할 수 있어요.
• 매달 고정적으로 나가는 보험비, 생활요금, 구독료 등도 쉽게 확인할 수 있어요.

• 평생 무료로 간편하고 안전하게, 송금
• 송금을 자유롭게, 토스에서는 은행 상관없이 수수료가 평생 무료에요.
• 송금을 안전하게, 송금 전 사기계좌를 미리 조회해 안전하게 송금할 수 있어요.


• 송금을 간편하게, 단 한 번의 터치까지 줄였어요. 최소한의 터치로 송금하세요.
• 그리고 마음까지, 간단한 메시지와 이모티콘을 함께 보내보 세요.
""")
    
}
