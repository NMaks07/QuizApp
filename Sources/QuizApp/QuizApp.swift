// The Swift Programming Language
// https://docs.swift.org/swift-book
import Vapor

@main
struct QuizApp {
    static func main() async throws {
        print("Hello, world!")
        let app = try await Application.make()
        
        let botToken = Environment.get("TELEGRAM_BOT_TOKEN") ?? ""
        let telegramAPI = "https://api.telegram.org/bot\(botToken)"
        var lastUpdateId: Int? = nil

        // Background task for polling
        Task.detached { () async -> Void in
            let client = app.client
            while true {
                do {
                    var url = "\(telegramAPI)/getUpdates?timeout=10"
                    if let offset = lastUpdateId {
                        url += "&offset=\(offset + 1)"
                    }
                    let response = try await client.get(URI(string: url))
                    let updates = try response.content.decode(TelegramResponse.self)
                    for update in updates.result {
                        lastUpdateId = update.update_id
                        if let message = update.message?.text,
                           let chatId = update.message.map({ String($0.chat.id) }) {
                            print("User said:", message)

                            // Reply back
                            let replyUrl = URI(string: "\(telegramAPI)/sendMessage")
                            try await client.post(replyUrl) { req in
                                try req.content.encode([
                                    "chat_id": chatId,
                                    "text": "Echo: \(message)"
                                ])
                            }
                        }
                    }
                } catch {
                    print("Polling error:", error)
                }
                
                try? await Task.sleep(nanoseconds: 2_000_000_000)
            }
        }
        
        app.get("hello") { (request) async -> String in
            "Hello, Vapor!"
        }
        
        try await app.execute()
    }
}

// MARK: - Telegram Models
struct TelegramResponse: Content {
    var ok: Bool
    var result: [TelegramUpdate]
}

struct TelegramUpdate: Content {
    var update_id: Int
    var message: TelegramMessage?
}

struct TelegramMessage: Content {
    var message_id: Int
    var chat: TelegramChat
    var text: String?
}

struct TelegramChat: Content {
    var id: Int64
    var type: String
}
