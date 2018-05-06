//
//  AVController.swift
//  App
//
//  Created by Apollo Zhu on 5/6/18.
//

import Vapor
import Foundation
import BilibiliKit

struct AVController {
    static func url(for aid: Int) -> Future<String> {
        let promise = EmbeddedEventLoop().newPromise(String.self)
        BKVideo(av: aid).getInfo {
            guard let url = $0?.coverImageURL else {
                return promise.fail(error: Abort(.notFound))
            }
            promise.succeed(result: url.absoluteString)
        }
        return promise.futureResult
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
}
