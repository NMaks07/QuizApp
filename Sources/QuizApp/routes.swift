import Vapor

public func routes(_ app: Application) throws {
    // Basic health check route
    app.get { req async throws -> String in
        "It works!"
    }
    
    
}
