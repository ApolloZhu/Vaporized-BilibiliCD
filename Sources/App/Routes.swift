import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("license") { _ in license }

    router.get("av", Int.parameter, use: AVController.get)
    router.get("download", Int.parameter, use: AVController.redirect)
}
