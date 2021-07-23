import Vapor
import Foundation
import BilibiliKit

struct VideoController: ResultController {
    static var route: [PathComponent] = ["av"]
    
    static func getInfo(for aid: Int, toComplete promise: EventLoopPromise<Info>) {
        BKVideo.av(aid).getInfo {
            promise.completeWith($0.map { bkInfo in
                Info(
                    url: bkInfo.coverImageURL.absoluteString,
                    title: bkInfo.title,
                    author: bkInfo.author.name
                )
            }.withTypeErasedError)
        }
    }
}

struct ArticleController: ResultController {
    static var route: [PathComponent] = ["cv"]
    
    static func getInfo(for cvID: Int, toComplete promise: EventLoopPromise<Info>) {
        BKArticle(cv: cvID).getInfo {
            promise.completeWith($0.map { bkInfo in
                Info(
                    url: bkInfo.coverImageURL.absoluteString,
                    title: bkInfo.title,
                    author: bkInfo.author
                )
            }.withTypeErasedError)
        }
    }
}

struct LiveRoomController: ResultController {
    static var route: [PathComponent] = ["lv"]
    
    static func getInfo(for id: Int, toComplete promise: EventLoopPromise<Info>) {
        BKLiveRoom(id).getInfo {
            promise.completeWith($0.map { bkInfo in
                Info(
                    url: bkInfo.coverImageURL.absoluteString,
                    title: bkInfo.title,
                    // FIXME: Look up author name (uname)
                    author: "\(bkInfo.mid)"
                )
            }.withTypeErasedError)
        }
    }
}

extension Result {
    var withTypeErasedError: Result<Success, Error> {
        mapError { $0 as Error }
    }
}
