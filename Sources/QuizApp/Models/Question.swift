//
//  Question.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Fluent
import Vapor

final class Question: Model, Content {
    static let schema = "questions"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "text")
    var text: String
    
    @Field(key: "order")
    var order: Int
    
    @OptionalField(key: "points")
    var points: Int?
    
    @Parent(key: "quiz_id")
    var quiz: Quiz
    
    @Enum(key: "type_kind")
    var typeKind: QuestionType
    
    @Children(for: \.$question)
    var answers: [Answer]
    
    init() {}
    
    init(id: UUID? = nil, text: String, order: Int, points: Int? = nil, quizId: UUID, typeKind: QuestionType) {
        self.text = text
        self.order = order
        self.points = points
        self.$quiz.id = quizId
        self.typeKind = typeKind
    }
}

extension Question: @unchecked Sendable {}

