import Vapor
import Foundation
import BilibiliKit

struct VideoController: ResultController {
    static func info(for aid: Int) -> Future<Info> {
        let promise = EmbeddedEventLoop().newPromise(Info.self)
        BKVideo(av: aid).getInfo {
            guard let bkInfo = $0 else {
                return promise.fail(error: Abort(.noContent))
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
}

struct ArticleController: ResultController {
    static func info(for cvID: Int) -> Future<Info> {
        let promise = EmbeddedEventLoop().newPromise(Info.self)
        BKArticle(cv: cvID).getInfo {
            guard let bkInfo = $0 else {
                return promise.fail(error: Abort(.noContent))
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
}

struct LiveRoomController: ResultController {
    static func info(for id: Int) -> Future<Info> {
        let promise = EmbeddedEventLoop().newPromise(Info.self)
        BKLiveRoom(id).getInfo {
            guard let bkInfo = $0 else {
                return promise.fail(error: Abort(.noContent))
            }
            let info = Info(
                url: bkInfo.coverImageURL.absoluteString,
                title: bkInfo.title,
                // FIXME: Look up author name (uname)
                author: "\(bkInfo.mid)"
            )
            promise.succeed(result: info)
        }
        return promise.futureResult
    }
}
