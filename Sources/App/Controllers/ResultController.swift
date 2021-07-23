import Vapor

protocol ResultController: RouteCollection {
    static var route: [PathComponent] { get }
    static func getInfo(for id: Int, toComplete promise: EventLoopPromise<Info>)
}
