import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("license") { _ in license }

    router.register(VideoController.self, asGroup: "av")
    router.register(ArticleController.self, asGroup: "cv")
    router.register(LiveRoomController.self, asGroup: "lv")
    
    router.get("/", use: SearchController.view)
}
