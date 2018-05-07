//
//  VideoController
//  App
//
//  Created by Apollo Zhu on 5/6/18.
//

import Vapor
import Foundation
import BilibiliKit

struct VideoController {

    static func info(for aid: Int) -> Future<Info> {
        let promise = EmbeddedEventLoop().newPromise(Info.self)
        BKVideo(av: aid).getInfo {
            guard let bkInfo = $0 else {
                return promise.fail(error: Abort(.notFound))
            }
            let info = Info(
                url: bkInfo.coverImageURL.absoluteString,
                title: bkInfo.title,
                author: bkInfo.author
            )
            promise.succeed(result: info)
        }
        return promise.futureResult
    }

    static func url(for aid: Int) -> Future<String> {
        return info(for: aid).map { $0.url }
    }

    static func get(_ req: Request) throws -> Future<String> {
        return url(for: try req.parameters.next(Int.self))
    }

    static func redirect(_ req: Request) throws -> Future<Response> {
        return try get(req).map { req.redirect(to: $0) }
    }

    static func download(_ req: Request) throws -> Future<Response> {
        return try get(req).flatMap { url in
            try req.client().get(url).map { response in
                response.http.headers.add(name: .contentDisposition, value: "attachment")
                return response
            }
        }
    }

    static func info(_ req: Request) throws -> Future<Info> {
        return try info(for: req.parameters.next(Int.self))
    }
}
