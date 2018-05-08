import Vapor

protocol ResultController {
    static func info(for id: Int) -> Future<Info>
}

extension ResultController {
    static func info(_ req: Request) throws -> Future<Info> {
        return try info(for: req.parameters.next(Int.self))
    }

    static func url(for aid: Int) -> Future<String> {
        return info(for: aid).map { $0.url }
    }
}
