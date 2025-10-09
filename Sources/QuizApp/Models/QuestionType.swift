//
//  QuestionType.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Fluent
import Vapor

// Represents the type of a question: single or multiple correct answers
enum QuestionType: String, Codable, CaseIterable, Sendable {
    case singleCorrect = "single_correct"
    // For questions with multiple correct answers where selecting any one correct answer suffices
    case multipleAny = "multiple_any"
    // For questions with multiple correct answers where all correct answers must be selected
    case multipleAll = "multiple_all"
}
