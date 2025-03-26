//
//  APIService.swift
//  macgelo-ios-swiftui
//
//  Created by Joey Villafuerte on 5/22/24.
//

import Foundation
import Moya

public class APIService<T: TargetType> {
    
    private(set) var provider: MoyaProvider<T>
    
    public required init(provider: MoyaProvider<T>) {
        self.provider = provider
        if #available(iOS 13.0, *) {
            self.provider.session.sessionConfiguration.allowsConstrainedNetworkAccess = false
        }
    }
    
    public func request(void request: T, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        self.execute(request) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func request(data request: T, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        self.execute(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func request(bool request: T, completion: @escaping (Swift.Result<Bool, Error>) -> Void) {
        self.execute(request) { result in
            switch result {
            case .success(let response):
                let okResponse = Array(200..<300).contains(response.statusCode)
                completion(.success(okResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func request<U: Decodable>(required request: T, type: U.Type, completion: @escaping (Swift.Result<U, Error>) -> Void) {
        self.execute(request) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(U.self, from: response.data)
                    completion(.success(decoded))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func request<U: Decodable>(optional request: T, type: U.Type, completion: @escaping (Swift.Result<U?, Error>) -> Void) {
        self.execute(request) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(U.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.success(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func cancelAllRequest() {
        self.provider.session.cancelAllRequests()
    }
}

// MARK: - Private functions
//
extension APIService {
    
    private func execute(_ request: T, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        self.validate(request) { status, error in
            guard status else {
                completion(Swift.Result.failure(error as! MoyaError))
                return
            }
            self.provider.request(request, completion: completion)
        }
    }
    
    private func validate(_ request: T, completion: @escaping (Bool, Error?) -> Void) {
        // Add request validation here
        // ex. SSL Pinning, etc.
        //
        completion(true, nil)
    }
}
