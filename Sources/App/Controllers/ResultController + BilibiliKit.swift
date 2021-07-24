import Vapor
import Foundation
import BilibiliKit

struct VideoController: ResultController {
    static var route = makePath("av")

    static func info(for aid: Int) async throws -> Info {
        return try await withCheckedThrowingContinuation { continuation in
            BKVideo.av(aid).getInfo {
                continuation.resume(with: $0.map { bkInfo in
                    Info(
                        url: bkInfo.coverImageURL.absoluteString,
                        title: bkInfo.title,
                        author: bkInfo.author.name
                    )
                })
            }
        }
    }
}

struct ArticleController: ResultController {
    static var route = makePath("cv")

    static func info(for cvID: Int) async throws -> Info {
        return try await withCheckedThrowingContinuation { continuation in
            BKArticle(cv: cvID).getInfo {
                continuation.resume(with: $0.map { bkInfo in
                    Info(
                        url: bkInfo.coverImageURL.absoluteString,
                        title: bkInfo.title,
                        author: bkInfo.author
                    )
                })
            }
        }
    }
}

struct LiveRoomController: ResultController {
    static var route = makePath("lv")

    static func info(for id: Int) async throws -> Info {
        return try await withCheckedThrowingContinuation { continuation in
            BKLiveRoom(id).getInfo {
                continuation.resume(with: $0.map { bkInfo in
                    Info(
                        url: bkInfo.coverImageURL.absoluteString,
                        title: bkInfo.title,
                        // FIXME: Look up author name (uname)
                        author: "\(bkInfo.mid)"
                    )
                })
            }
        }
    }
}
