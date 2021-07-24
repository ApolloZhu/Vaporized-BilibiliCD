import Leaf
import Vapor

/// Called before your application initializes.
public func configure(_ app: Application) throws {
    print(License.notice)

    /// Use Leaf for view rendering.
    app.views.use(.leaf)

    try routes(app)
}
