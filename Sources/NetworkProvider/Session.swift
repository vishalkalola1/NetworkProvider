//
//  SessionProtocol.swift
//  NetworkProvider
//
//  Created by Vishal on 11/10/2022.
//

import Foundation

public class Session: SessionProtocol {
    public let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func dataTask<T: Decodable>(_ request: URLRequest, dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        
        return session.dataTask(with: request) { [weak self] data, response, error in
            completion(Result<T, Error> {
                guard let self = self else {
                    throw NetworkError.operationCancelled
                }
                
                if let requestError = error {
                    throw NetworkError.requestFailed(error: requestError)
                }
                
                try self.validate(response: response, statusCodes: Environment.successStatusCodeRange)
                return try self.decode(data: data, type: dataType)
            })
        }
    }
}

private extension Session {
    func validate(response: URLResponse?, statusCodes: Range<Int>) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownStatusCode
        }
        
        if !statusCodes.contains(httpResponse.statusCode) {
            throw NetworkError.unexpectedStatusCode(code: httpResponse.statusCode)
        }
    }
    
    func decode<T: Decodable>(data: Data?, type: T.Type) throws -> T {
        guard let data = data, !data.isEmpty else {
            throw NetworkError.contentEmptyData
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw NetworkError.contentDecoding(error: error)
        }
    }
}
