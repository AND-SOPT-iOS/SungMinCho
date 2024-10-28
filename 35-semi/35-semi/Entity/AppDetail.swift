//
//  AppDetail.swift
//  35-semi
//
//  Created by 조성민 on 10/17/24.
//

import UIKit
import Foundation

struct AppDetail {
    
    let title: String
    let subtitle: String
    let imageName: String
    let version: String
    let news: String
    let updateDate: Date
    let ageLimit: Int
    let award: Award
    let explanation: String
    let developer: String
    let bestReviews: [Review]
    let reviewDistribution: ReviewDistribution
    
    init(
        title: String,
        subtitle: String,
        imageName: String,
        version: String,
        news: String,
        updateDate: Date,
        ageLimit: Int,
        award: Award,
        explanation: String,
        developer: String,
        bestReviews: [Review],
        reviewDistribution: ReviewDistribution
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.version = version
        self.news = news
        self.updateDate = updateDate
        self.ageLimit = ageLimit
        self.award = award
        self.explanation = explanation
        self.developer = developer
        self.bestReviews = bestReviews
        self.reviewDistribution = reviewDistribution
    }
    
}
