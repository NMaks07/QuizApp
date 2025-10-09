//
//  ModelsMigrations.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Fluent
import FluentSQL
import Vapor

struct CreateQuiz: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("quizzes")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .field("is_published", .bool, .required, .sql(.default(false)))
            .field("time_limit", .int)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("quizzes").delete()
    }
}

struct CreateQuestionType: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("question_types")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("question_types").delete()
    }
}

struct CreateQuestion: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("questions")
            .id()
            .field("text", .string, .required)
            .field("order", .int, .required)
            .field("points", .int)
            .field("quiz_id", .uuid, .required, .references("quizzes", "id", onDelete: .cascade))
            .field("type_id", .uuid, .required, .references("question_types", "id", onDelete: .restrict))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("questions").delete()
    }
}

struct CreateAnswer: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("answers")
            .id()
            .field("text", .string, .required)
            .field("is_correct", .bool, .required)
            .field("order", .int, .required)
            .field("explanation", .string)
            .field("question_id", .uuid, .required, .references("questions", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("answers").delete()
    }
}

struct CreateAttendee: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Attendee.schema)
            .id()
            .field("name", .string, .required)
            .field("phone_number", .string, .required)
            .unique(on: "phone_number")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(Attendee.schema).delete()
    }
}

struct CreateQuizResult: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("quiz_results")
            .id()
            .field("attendee_id", .uuid, .required, .references("attendees", "id"))
            .field("quiz_id", .uuid, .required, .references("quizzes", "id"))
            .field("question_id", .uuid, .required, .references("questions", "id"))
            .field("answer_id", .uuid, .required, .references("answers", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("quiz_results").delete()
    }
}
