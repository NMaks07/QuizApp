//
//  QuizResults.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 09/10/25.
//

import Fluent
import Vapor

final class QuizResult: Model, Content {
    static let schema = "quiz_results"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "attendee_id")
    var attendee: Attendee

    @Parent(key: "quiz_id")
    var quiz: Quiz

    @Parent(key: "question_id")
    var question: Question

    @Parent(key: "answer_id")
    var answer: Answer

    init() { }

    init(
        id: UUID? = nil,
        attendeeID: UUID,
        quizID: UUID,
        questionID: UUID,
        answerID: UUID
    ) {
        self.id = id
        self.$attendee.id = attendeeID
        self.$quiz.id = quizID
        self.$question.id = questionID
        self.$answer.id = answerID
    }
}

extension QuizResult: @unchecked Sendable {}
