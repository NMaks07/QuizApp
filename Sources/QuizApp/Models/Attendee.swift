//
//  Attendee.swift
//  QuizApp
//
//  Created by Nodirbek Maksumov on 07/10/25.
//

import Fluent
import Vapor

final class Attendee: Model, Content {
    static let schema = "attendees"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "phone_number")
    var phoneNumber: String

    @Children(for: \.$attendee)
    var QuizResults: [QuizResult]
    
    init() { }

    init(id: UUID? = nil, name: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
}

extension Attendee: @unchecked Sendable {}
