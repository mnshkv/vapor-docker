import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello", ":name") { req -> String in
        if let name = req.parameters.get("name") {
            return "Hello, \(name)"
        }

        return "name is not find"
    }
}
