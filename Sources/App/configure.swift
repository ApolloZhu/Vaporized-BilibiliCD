import Leaf
import Vapor

class MyErrorMiddleware: Middleware, ServiceType {
    class func makeService(for worker: Container) throws -> Self {
        return try .default(environment: worker.environment, log: worker.make())
    }
    
    class func `default`(environment: Environment, log: Logger) -> Self {
        struct ErrorResponse: Encodable {
            var error: UInt
            var reason: String
        }
        
        return .init { req, error in
            // log the error
            log.report(error: error, verbose: !environment.isRelease)
            
            // variables to determine
            let status: HTTPResponseStatus
            let reason: String
            var headers: HTTPHeaders = [:]
            
            // inspect the error type
            switch error {
            case let abort as AbortError:
                // this is an abort error, we should use its status, reason, and headers
                reason = abort.reason
                status = abort.status
                headers = abort.headers
            case let validation as ValidationError:
                // this is a validation error
                reason = validation.reason
                status = .badRequest
            case let debuggable as Debuggable where !environment.isRelease:
                // if not release mode, and error is debuggable, provide debug
                // info directly to the developer
                reason = debuggable.reason
                status = .internalServerError
            default:
                reason = "Something went wrong."
                status = .internalServerError
            }
            let res = req.makeResponse(http: .init(status: status, headers: headers))
            do {
                let errorResponse = ErrorResponse(error: status.code, reason: reason)
                res.http.body = try HTTPBody(data: JSONEncoder().encode(errorResponse))
                res.http.headers.replaceOrAdd(name: .contentType, value: "application/json; charset=utf-8")
            } catch {
                res.http.body = HTTPBody(string: "Oops: \(error)")
                res.http.headers.replaceOrAdd(name: .contentType, value: "text/plain; charset=utf-8")
            }
            return res
        }
    }
    
    private let closure: (Request, Error) -> (Response)
    
    public init(_ closure: @escaping (Request, Error) -> (Response)) {
        self.closure = closure
    }
    
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        let response: Future<Response>
        do {
            response = try next.respond(to: req)
        } catch {
            response = req.eventLoop.newFailedFuture(error: error)
        }
        return response.mapIfError { error in
            return self.closure(req, error)
        }
    }
}


/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    /// To enable routes rendering Leaf templates as needed
    try services.register(LeafProvider())
}
