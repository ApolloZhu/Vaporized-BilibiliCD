import Vapor

/// Register your application's routes here.
func routes(_ app: Application) throws {
    app.get("license") { req in
        req.redirect(to: "https://github.com/ApolloZhu/Vaporized-BilibiliCD/blob/master/LICENSE")
    }

    try app.register(collection: VideoController())
    try app.register(collection: ArticleController())
    try app.register(collection: LiveRoomController())

    // Search UI
    app.get { req in
        return req.view.render("main")
    }
}
