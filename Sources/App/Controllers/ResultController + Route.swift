import Vapor

extension Router {
    func register(_ controller: ResultController.Type,
                  asGroup path: PathComponentsRepresentable...) {
        group(path) { router in
            router.get("download", Int.parameter, use: controller.downloadImage)
            router.get("show", Int.parameter, use: controller.redirectToSource)
            router.get("url", Int.parameter, use: controller.plainStringURL)
            router.get("info", Int.parameter, use: controller.info)
            // router.get(all, Int.parameter, use: controller.view)
        }
    }
}

extension ResultController {
    static func plainStringURL(_ req: Request) throws -> Future<String> {
        return url(for: try req.parameters.next(Int.self))
    }

    static func redirectToSource(_ req: Request) throws -> Future<Response> {
        return try plainStringURL(req).map { req.redirect(to: $0) }
    }

    static func downloadImage(_ req: Request) throws -> Future<Response> {
        return try plainStringURL(req).flatMap { url in
            try req.client().get(url)
        }.map { response in
            response.http.headers.add(
                name: .contentDisposition,
                value: "attachment"
            )
            return response
        }
    }

//    static func view(_ req: Request) -> Future<View> {
//        req.parameters
//    }
}
