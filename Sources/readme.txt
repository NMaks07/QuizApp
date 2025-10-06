//
//  readme.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 29/09/25.
//

1) install Vapor
2) run Vapor Hello world app
3) create telegram bot with Telegram's botfather (t.me/Quizzmasterbot)
4) make Task for polling from telegram api, reply by echoing
5) add Fluent + PostgreSQL
6) Create quiz models/migrations (quiz, question, questionType, answer)
7) install docker:
    docker run --name quiz-postgres \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=quizapp \
    -p 5432:5432 \
    -d postgres:15
8) run migrations in bash:
    swift run QuizApp migrate
