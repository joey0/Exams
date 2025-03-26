//
//  FakeMoyaProvider.swift
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Moya

public class FakeMoyaProvider<Target: TargetType> {
    
    public lazy var statusCode: Int = 200
    public var mockData: Data?
    public var targetReceived: TargetType?
    
    /// Creates a fake Moya Provider.
    ///
    /// - Parameters:
    ///     - response: An `Int` identifying response's code
    ///     - stubBehavior: A case of `StubBehavior`
    /// - Returns: An instance of `MoyaProvider` with a generic `Target`
    public func getProvider(response: Int = 200, statusError: Bool = false, stubBehavior: StubBehavior = .delayed(seconds: 0.1)) -> MoyaProvider<Target> {
        self.statusCode = response
        let endpointClosure = { (target: Target) -> Endpoint in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            return Endpoint(
                url: url,
                sampleResponseClosure: {
                    return statusError ? .networkError(
                        NSError(domain: url, code: self.statusCode)
                    ) : .networkResponse(
                        self.statusCode, self.mockData ?? target.sampleData
                    )
                },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        return MoyaProvider<Target>(
            endpointClosure: endpointClosure,
            stubClosure: { (target: Target) -> Moya.StubBehavior in
                self.targetReceived = target
                return stubBehavior
        })
    }
}
