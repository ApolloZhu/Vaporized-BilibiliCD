import Vapor

/// Register your application's routes here.
func routes(_ app: Application) throws {
    app.get("license") { req in
        req.redirect(to: License.url)
    }

    try app.register(collection: VideoController())
    try app.register(collection: ArticleController())
    try app.register(collection: LiveRoomController())

    // Search UI
    app.get { req in
        req.view.render("main")
    }
}
