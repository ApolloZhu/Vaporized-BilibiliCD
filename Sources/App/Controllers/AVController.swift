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
    static func get(_ req: Request) throws -> Future<Response> {
        let aid = try req.parameters.next(Int.self)
        let video = BKVideo(av: aid)
        let promise = req.eventLoop.newPromise(Response.self)
        video.getInfo {
            guard let url = $0?.coverImageURL.absoluteString else {
                return promise.fail(error: Abort(.notFound))
            }
            promise.succeed(result: req.redirect(to: url))
        }
        return promise.futureResult
    }
}
