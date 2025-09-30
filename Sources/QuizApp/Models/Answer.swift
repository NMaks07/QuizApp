//
//  Answer.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Fluent
import Vapor

final class Answer: Model, Content {
    static let schema = "answers"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "text")
    var text: String
    
    @Field(key: "is_correct")
    var isCorrect: Bool
    
    @Field(key: "order")
    var order: Int
    
    @OptionalField(key: "explanation")
    var explanation: String?
    
    @Parent(key: "question_id")
    var question: Question
    
    init() {}
    
    init(id: UUID? = nil, text: String, isCorrect: Bool, order: Int, explanation: String? = nil, questionId: UUID) {
        self.text = text
        self.isCorrect = isCorrect
        self.order = order
        self.explanation = explanation
        self.$question.id = questionId
    }
}

extension Answer: @unchecked Sendable {}
