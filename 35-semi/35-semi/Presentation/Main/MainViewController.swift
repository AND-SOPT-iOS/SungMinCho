//
//  MainViewController.swift
//  35-semi
//
//  Created by 조성민 on 10/5/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Toss 상세화면 보기", for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 10
        button.setTitleColor(
            .label,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(nextButtonTapped), for: .touchUpInside
        )
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override func setStyle() {
        self.view.backgroundColor = .systemBackground
    }
    
    override func setUI() {
        [nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate(
            [
                nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.heightAnchor.constraint(equalToConstant: 50),
                nextButton.widthAnchor.constraint(equalToConstant: 200)
            ]
        )
    }
    
    @objc
    func nextButtonTapped() {
        let nextViewController = DetailViewController(
            detail: AppDetail(
                title: "토스",
                subtitle: "금융이 쉬원진다",
                imageName: "toss",
                version: "5.183.0",
                news: "- 구석구석 숨어있던 버그들을 잡았어요. 또 다른 버그가 나타나면 토스 고객센터를 찾아주세요. 늘 열려있답니다. 365일 24시간 언제든지요.",
                updateDate: Date(
                    year: 2024,
                    month: 9,
                    day: 13
                ),
                ageLimit: 4,
                award: .editorChoice,
                explanation: """
토스뱅크, 토스증권 서비스를 이용하시려면 토스 앱 설치가 필요합니다.
• 모든 계좌의 모든 정보를 한 곳에서, 따로 보았던 예적금, 청약, 증권, 대출 계좌의 정보를 한 곳에서 확인할 수 있어요.
• 얼마나 벌고 얼마나 썼을까? 한 달 동안의 수입과 소비를 시간 순으로 모아볼 수 있고, 소비 분석 리포트도 제공해드려요.
토스뱅크, 토스증권 서비스를 이용하시려면 토스 앱 설치가 필요합니다.

• 내 금융 현황을 한눈에, 홈•소비
• 모든 계좌의 모든 정보를 한 곳에서, 따로 보았던 예적금, 청약, 증권, 대출 계좌의 정보를 한 곳에서 확인할 수 있어요.
• 얼마나 벌고 얼마나 썼을까? 한 달 동안의 수입과 소비를 시간 순으로 모아볼 수 있고, 소비 분석 리포트도 제공해드려요.
• 카드 실적 헷갈릴 필요 없이, 실적을 충족한 카드가 무엇인지 얼마나 더 써야 실적을 달성하는지 한눈에 확인할 수 있어요.
• 매달 고정적으로 나가는 보험비, 생활요금, 구독료 등도 쉽게 확인할 수 있어요.

• 평생 무료로 간편하고 안전하게, 송금
• 송금을 자유롭게, 토스에서는 은행 상관없이 수수료가 평생 무료에요.
• 송금을 안전하게, 송금 전 사기계좌를 미리 조회해 안전하게 송금할 수 있어요.
• 송금을 간편하게, 단 한 번의 터치까지 줄였어요. 최소한의 터치로 송금하세요.
• 그리고 마음까지, 간단한 메시지와 이모티콘을 함께 보내보 세요.
""",
                developer: "Viva Republica",
                bestReviews: [
                    Review(
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
                ],
                reviewDistribution: ReviewDistribution(
                    five: 58800,
                    four: 10920,
                    three: 2520,
                    two: 840,
                    one: 10920
                )
            )
        )
        self.navigationController?.pushViewController(
            nextViewController,
            animated: true
        )
    }
    
}
