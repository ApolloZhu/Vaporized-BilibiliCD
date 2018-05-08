import Vapor
import Leaf

struct SearchController {
    static func view(_ req: Request) throws -> Future<View> {
        let leaf = try req.make(LeafRenderer.self)
        let context = [String:String]()
        return leaf.render("main", context)
    }
}
