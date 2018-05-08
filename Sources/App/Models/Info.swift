import Vapor

struct Info: Content {
    let url: String
    let title: String
    let author: String
}
