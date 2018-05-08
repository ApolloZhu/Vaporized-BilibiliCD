import Vapor
import Foundation
import BilibiliKit

struct VideoController: ResultController {
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
}
