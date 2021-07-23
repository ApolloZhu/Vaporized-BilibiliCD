import Leaf
import Vapor

let license = """
Vaporized BilibiliCD.  Copyright (C) 2018-2021  Zhiyu Zhu (@ApolloZhu)
This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
This is free software, and you are welcome to redistribute it
under certain conditions; request /license for details.

"""

typealias Future = EventLoopFuture

/// Called before your application initializes.
public func configure(_ app: Application) throws {
    print(license)

    /// Use Leaf for view rendering.
    app.views.use(.leaf)

    try routes(app)
}
