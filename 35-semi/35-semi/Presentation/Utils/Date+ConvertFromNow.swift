//
//  Date+ConvertFromNow.swift
//  35-semi
//
//  Created by 조성민 on 10/23/24.
//

import Foundation

extension Date {
    
    func convertFromNow() -> String {
        let diff = Date().timeIntervalSince(self)
        
        switch diff {
        case ..<60:
            return "방금 전"
        case 60..<3600:
            return "\(Int(diff / 60))분 전"
        case 3600..<86400:
            return "\(Int(diff / 3600))시간 전"
        case 86400..<604800:
            return "\(Int(diff / 86400))일 전"
        case 604800..<2592000:
            return "\(Int(diff / 604800))주 전"
        case 2592000..<31536000:
            return "\(Int(diff / 2592000))개월 전"
        default:
            return "\(Int(diff / 31536000))년 전"
        }
    }
    
    func convertToString() -> String {
        if Date().timeIntervalSince(self) >= 31536000 {
            return convertFromNow()
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "M월 d일"
            return formatter.string(from: self)
        }
    }
    
}
