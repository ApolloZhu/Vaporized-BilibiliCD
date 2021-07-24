import Vapor

protocol ResultController: RouteCollection {
    static var route: [PathComponent] { get }
    static func info(for id: Int) async throws -> Info
}

func makePath(_ components: PathComponent...) -> [PathComponent] {
    return components
}
