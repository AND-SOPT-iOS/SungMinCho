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

extension Review {
    
    static let sampleReviews: [Review] = [
        Review(
            writer: "조성민",
            writeDate: Date(),
            title: "폰트 크기 복구해주세요.....",
            score: Score.four,
            content: "폰트 크기가 바뀌었는데 어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요  어쩌구 저쩌구 그랬습니다요 저랬습니다요 ",
            developerAnswer: "그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~그랬구나~",
            devleoperAnswerDate: Date()
        ),
        Review(
            writer: "김철수",
            writeDate: Date(),
            title: "앱이 자주 꺼져요",
            score: Score.two,
            content: "앱이 자주 꺼져서 불편해요. 특히 중요한 작업 중에 갑자기 꺼지면 정말 스트레스를 받습니다. 이 문제를 해결해 주시면 정말 감사하겠습니다. 사용자가 더 이상 불편함을 겪지 않도록 해주세요.",
            developerAnswer: "불편을 드려서 정말 죄송합니다. 저희 팀이 이 문제를 최우선으로 해결하도록 하겠습니다. 추가적인 정보가 필요하시면 언제든지 연락주세요.",
            devleoperAnswerDate: Date()
        ),
        Review(
            writer: "이영희",
            writeDate: Date(),
            title: "사용하기 편해요",
            score: Score.five,
            content: "정말 유용한 앱이에요! 사용하기도 쉽고, 기능도 다양해서 매일 사용하고 있습니다. 특히 UI가 직관적이라서 처음 사용하는 사람도 쉽게 적응할 수 있을 것 같아요.",
            developerAnswer: "감사합니다! 저희는 사용자 여러분의 피드백을 소중히 여기고 있습니다. 앞으로도 더 나은 서비스를 제공하기 위해 노력하겠습니다!",
            devleoperAnswerDate: Date()
        ),
        Review(
            writer: "박지민",
            writeDate: Date(),
            title: "버그가 있어요",
            score: Score.three,
            content: "몇 가지 버그가 발견됐어요. 특히 앱이 특정 상황에서 멈추는 경우가 많아서 불편합니다. 이 문제를 해결해 주시면 좋겠습니다.",
            developerAnswer: "보고해주셔서 감사합니다. 저희가 이 문제를 조사하고 있으며, 가능한 한 빨리 수정하도록 하겠습니다.",
            devleoperAnswerDate: Date()
        ),
        Review(
            writer: "최민수",
            writeDate: Date(),
            title: "디자인이 마음에 들어요",
            score: Score.four,
            content: "디자인이 깔끔하고 좋습니다. 색상 조합도 마음에 들고, 사용하기에도 편리합니다.",
            developerAnswer: nil,
            devleoperAnswerDate: nil
        )
    ]
    
}
