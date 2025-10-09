//
//  configure.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 30/09/25.
//

import Vapor
import Fluent
import FluentPostgresDriver
import Leaf

public func configure(_ app: Application) throws {
    // Database setup with PostgresConfiguration
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: "localhost", port: 5432,
                username: "postgres", password: "password",
                database: "quizapp",
                tls: .disable
            )
        ),
        as: .psql
    )

    // Register migrations
    app.migrations.add(CreateQuiz())
    app.migrations.add(CreateQuestion())
    app.migrations.add(CreateAnswer())
    app.migrations.add(CreateAttendee())
    app.migrations.add(CreateQuizResult())

    app.views.use(.leaf)
    // Auto-migrate on startup
    try app.autoMigrate().wait()
    
    try routes(app)
}

