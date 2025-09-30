//
//  Quiz.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Fluent
import Vapor

final class Quiz: Model, Content {
    static let schema = "quizzes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @OptionalField(key: "description")
    var description: String?
    
    @Field(key: "is_published")
    var isPublished: Bool
    
    @OptionalField(key: "time_limit")
    var timeLimit: Int? // in seconds
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Children(for: \.$quiz)
    var questions: [Question]
    
    init() {}
    
    init(id: UUID? = nil, title: String, description: String? = nil, isPublished: Bool = false, timeLimit: Int? = nil) {
        self.title = title
        self.description = description
        self.isPublished = isPublished
        self.timeLimit = timeLimit
    }
}

extension Quiz: @unchecked Sendable {}
