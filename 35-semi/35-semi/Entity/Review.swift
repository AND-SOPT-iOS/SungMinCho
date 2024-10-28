//
//  Review.swift
//  35-semi
//
//  Created by 조성민 on 10/19/24.
//

import Foundation

struct Review {
    
    let writer: String
    let writeDate: Date
    let title: String
    let score: Score
    let content: String
    let developerAnswer: String?
    let devleoperAnswerDate: Date?
    
    init(
        writer: String,
        writeDate: Date,
        title: String,
        score: Score,
        content: String,
        developerAnswer: String? = nil,
        devleoperAnswerDate: Date? = nil
    ) {
        self.writer = writer
        self.writeDate = writeDate
        self.title = title
        self.score = score
        self.content = content
        self.developerAnswer = developerAnswer
        self.devleoperAnswerDate = devleoperAnswerDate
    }
    
}
