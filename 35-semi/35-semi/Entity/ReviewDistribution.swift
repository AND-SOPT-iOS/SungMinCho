//
//  ReviewDistribution.swift
//  35-semi
//
//  Created by 조성민 on 10/19/24.
//

import Foundation

struct ReviewDistribution {
    
    private let five: Int
    private let four: Int
    private let three: Int
    private let two: Int
    private let one: Int
    
    
    var averageScore: Double {
        let rawScore = Double(one + two * 2 + three * 3 + four * 4 + five * 5) / Double(totalCount)
        return round(rawScore * 10) / 10
    }
    
    var totalCount: Int {
        one + two + three + four + five
    }
    
    var translatedTotalCountString: String {
        var text = ""
        if totalCount >= 10000 {
            let result = Double(totalCount) / 10000
            if result == floor(result) {
                text = String(format: "%.0f만", result)
            } else {
                text = String(format: "%.1f만", result)
            }
        } else if totalCount >= 1000 {
            let result = Double(totalCount) / 1000
            if result == floor(result) {
                text = String(format: "%.0f천", result)
            } else {
                text = String(format: "%.1f천", result)
            }
        } else {
            text = String(totalCount)
        }
        return text
    }
    
    init(five: Int, four: Int, three: Int, two: Int, one: Int) {
        self.five = five
        self.four = four
        self.three = three
        self.two = two
        self.one = one
    }
    
    func getRatio(score: Score) -> Double {
        switch score {
        case .five:
            Double(five) / Double(totalCount)
        case .four:
            Double(four) / Double(totalCount)
        case .three:
            Double(three) / Double(totalCount)
        case .two:
            Double(two) / Double(totalCount)
        case .one:
            Double(one) / Double(totalCount)
        }
    }
    
}
