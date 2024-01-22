//
//  Session.swift
//  KLMAssigment
//
//  Created by vishal on 4/18/23.
//

import Foundation

public protocol SessionProtocol {
    func dataTask<T: Decodable>(_ request: URLRequest, dataType: T.Type) async throws -> T
}

public class Session: SessionProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func dataTask<T: Decodable>(_ request: URLRequest, dataType: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            try self.validate(response: response, statusCodes: Environment.successStatusCodeRange)
            return try self.decode(data: data, type: dataType)
        } catch {
            throw NetworkError.requestFailed(error: error)
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
