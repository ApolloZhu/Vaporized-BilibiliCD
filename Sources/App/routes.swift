import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("license") { _ in license }

    router.group("av") { videoRouter in
        videoRouter.get("download", Int.parameter, use: VideoController.download)
        videoRouter.get("show", Int.parameter, use: VideoController.redirect)
        videoRouter.get("url", Int.parameter, use: VideoController.get)
        videoRouter.get("info", Int.parameter, use: VideoController.info)
        videoRouter.get(all, Int.parameter, use: VideoController.get)
    }
}
