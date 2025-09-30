//
//  QuestionType.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Fluent
import Vapor

final class QuestionType: Model, Content {
    static let schema = "question_types"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @OptionalField(key: "description")
    var description: String?
    
    @Children(for: \.$type)
    var questions: [Question]
    
    init() {}
    
    init(id: UUID? = nil, title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }
}

extension QuestionType: @unchecked Sendable {}
