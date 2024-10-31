//
//  App.swift
//  35-semi
//
//  Created by 조성민 on 10/26/24.
//

import Foundation

struct App {
    
    let title: String
    let subtitle: String
    let rank: Int
    let downloadState: DownloadState
    let category: Category
    let imageName: String
    let price: Int
    
    init(
        title: String,
        subtitle: String? = nil,
        rank: Int,
        downloadState: DownloadState,
        category: Category,
        imageName: String,
        price: Int = 0
    ) {
        self.title = title
        if let subtitle = subtitle {
            self.subtitle = subtitle
        } else {
            self.subtitle = category.rawValue
        }
        self.rank = rank
        self.downloadState = downloadState
        self.category = category
        self.imageName = imageName
        self.price = price
    }
    
    var downloadButtonTitle: String? {
        if price == 0 {
            switch downloadState {
            case .updatable:
                return "업데이트"
            case .downloadable:
                return "받기"
            case .downloaded:
                return "열기"
            case .reDownloadable:
                return nil
            }
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "ko_KR")
            if let formattedString = formatter.string(from: NSNumber(value: price)) {
                return "₩\(formattedString)"
            }
            return "₩\(price)"
        }
    }
    
}

extension App {
    
    static let financialApps: [App] = [
        App(
            title: "현대카드",
            rank: 1,
            downloadState: .downloadable,
            category: .finance,
            imageName: "hyundaicard"
        ),
        App(
            title: "현대백화점",
            rank: 2,
            downloadState: .updatable,
            category: .finance,
            imageName: "hyundaidepartment"
        ),
        App(
            title: "카카오뱅크",
            subtitle: "이미 모두의 은행",
            rank: 3,
            downloadState: .downloaded,
            category: .finance,
            imageName: "kakaobank"
        ),
        App(
            title: "카카오페이",
            subtitle: "마음 놓고 금융하다",
            rank: 4,
            downloadState: .downloadable,
            category: .finance,
            imageName: "kakaopay",
            price: 100000
        ),
        App(
            title: "케이뱅크",
            subtitle: "make money",
            rank: 5,
            downloadState: .reDownloadable,
            category: .finance,
            imageName: "kbank"
        ),
        App(
            title: "KBPay",
            subtitle: "모든 금융을 한번에, 한손에, 한눈에 담다",
            rank: 6,
            downloadState: .downloadable,
            category: .finance,
            imageName: "kbpay"
        ),
        App(
            title: "모바일티머니",
            rank: 7,
            downloadState: .updatable,
            category: .finance,
            imageName: "mobileTmoney"
        ),
        App(
            title: "monimo (모니모, 삼성 금융네트웍스)",
            subtitle: "모이는 금융, 커지는 혜택! monimo",
            rank: 8,
            downloadState: .downloaded,
            category: .finance,
            imageName: "monimo"
        ),
        App(
            title: "네이버페이",
            subtitle: "지갑 없이 매장에서 결제",
            rank: 9,
            downloadState: .reDownloadable,
            category: .finance,
            imageName: "naverpay"
        ),
        App(
            title: "PASS by SKT",
            subtitle: "인증을 넘어 일상으로 PASS",
            rank: 10,
            downloadState: .downloaded,
            category: .finance,
            imageName: "pass"
        ),
        App(
            title: "실손24",
            subtitle: "간편한 실손 보험 청구",
            rank: 11,
            downloadState: .downloadable,
            category: .finance,
            imageName: "silson24"
        ),
        App(
            title: "토스",
            subtitle: "금융이 쉬워진다",
            rank: 12,
            downloadState: .downloaded,
            category: .finance,
            imageName: "toss"
        )
    ]
    
}
