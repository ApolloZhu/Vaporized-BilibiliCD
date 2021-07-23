import Vapor

extension ResultController {
    func boot(routes: RoutesBuilder) throws {
        let root = routes.grouped(Self.route)
        root.get("download", ":id", use: Self.downloadImage)
        root.get("show", ":id", use: Self.redirectToSource)
        root.get("url", ":id", use: Self.plainStringURL)
        root.get("info", ":id", use: Self.info)
    }

    static func id(from req: Request) throws -> Int {
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: "Missing id")
        }
        return id
    }
}

extension ResultController {
    static func info(_ req: Request) throws -> Future<Info> {
        let id = try id(from: req)
        let promise = req.eventLoop.makePromise(of: Info.self)
        getInfo(for: id, toComplete: promise)
        return promise.futureResult
    }

    static func plainStringURL(_ req: Request) throws -> Future<String> {
        return try info(req).map { $0.url }
    }

    static func redirectToSource(_ req: Request) throws -> Future<Response> {
        return try plainStringURL(req).map { req.redirect(to: $0) }
    }

    static func downloadImage(_ req: Request) throws -> Future<ClientResponse> {
        return try plainStringURL(req).flatMap { url in
            req.client.get(URI(string: url))
        }.map { response in
            var copy = response
            copy.headers.add(
                name: .contentDisposition,
                value: "attachment"
            )
            return copy
        }
    }
}
