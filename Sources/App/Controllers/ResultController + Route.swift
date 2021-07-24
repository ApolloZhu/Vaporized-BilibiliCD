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
            throw Abort(.badRequest, reason: "Missing or invalid id")
        }
        return id
    }
}

extension ResultController {
    static func info(_ req: Request) async throws -> Info {
        let id = try id(from: req)
        return try await info(for: id)
    }

    static func plainStringURL(_ req: Request) async throws -> String {
        try await info(req).url
    }

    static func redirectToSource(_ req: Request) async throws -> Response {
        req.redirect(to: try await plainStringURL(req))
    }

    static func downloadImage(_ req: Request) async throws -> ClientResponse {
        var response = try await req.client.get(URI(string: plainStringURL(req)))
        response.headers.add(
            name: .contentDisposition,
            value: "attachment"
        )
        return response
    }
}
