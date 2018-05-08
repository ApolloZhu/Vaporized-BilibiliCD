import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("license") { _ in license }

    router.register(VideoController.self, asGroup: "av")

    router.get("/", use: SearchController.view)
}
