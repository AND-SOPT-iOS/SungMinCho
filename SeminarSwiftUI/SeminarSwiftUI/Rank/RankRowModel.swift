//
//  RankRowModel.swift
//  SeminarSwiftUI
//
//  Created by 조성민 on 12/10/24.
//

import Foundation

struct RankRowModel: Identifiable, Hashable {
    
    let imageName: String
    let rank: Int
    let title: String
    let subtitle: String
    let downloadState: DownloadState
    let id = UUID()
    
}

enum DownloadState {
    
    case downloadable
    case updatable
    case open
    case redownload
    
    func label() -> String {
        switch self {
        case .downloadable:
            "받기"
        case .updatable:
            "업데이트"
        case .open:
            "열기"
        case .redownload:
            ""
        }
    }
    
}

extension RankRowModel {
    
    static let mockData: RankRowModel = .init(
        imageName: "kakaobank",
        rank: 1,
        title: "카카오뱅크",
        subtitle: "이미 모두의 은행",
        downloadState: .redownload
    )
    
    static let mockDataArray: [RankRowModel] = [
        .init(
            imageName: "hyundaicard",
            rank: 1,
            title: "현대카드",
            subtitle: "금융",
            downloadState: .open
        ),
        .init(
            imageName: "hyundaidepartment",
            rank: 2,
            title: "현대백화점",
            subtitle: "현대백화점인디",
            downloadState: .updatable
        ),
        .init(
            imageName: "kakaobank",
            rank: 3,
            title: "카카오뱅크",
            subtitle: "카카오뱅크는 잘나가요",
            downloadState: .downloadable
        ),
        .init(
            imageName: "kakaopay",
            rank: 4,
            title: "카카오페이",
            subtitle: "카카오페이는 페이페이",
            downloadState: .open
        ),
        .init(
            imageName: "kbank",
            rank: 5,
            title: "케이뱅크",
            subtitle: "케이뱅크는 케이케이",
            downloadState: .open
        ),
        .init(
            imageName: "kbpay",
            rank: 6,
            title: "KBPay",
            subtitle: "KB 페이페이페이",
            downloadState: .downloadable
        ),
        .init(
            imageName: "mobileTmoney",
            rank: 7,
            title: "모바일 티머니",
            subtitle: "금융",
            downloadState: .open
        ),
        .init(
            imageName: "monimo",
            rank: 8,
            title: "모니모",
            subtitle: "모니모니해도",
            downloadState: .redownload
        ),
        .init(
            imageName: "naverpay",
            rank: 9,
            title: "네이버페이",
            subtitle: "네이버페이는 잘가요",
            downloadState: .updatable
        ),
        .init(
            imageName: "toss",
            rank: 10,
            title: "토스",
            subtitle: "금융이 쉬워진다",
            downloadState: .open
        ),
        .init(
            imageName: "pass",
            rank: 11,
            title: "패스",
            subtitle: "스루 패스",
            downloadState: .redownload
        ),
        .init(
            imageName: "silson24",
            rank: 12,
            title: "실손24",
            subtitle: "실손실손실실손손",
            downloadState: .updatable
        ),
        
    ]
    
}
