//
//  NetworkProvider.swift
//  KLMAssigment
//
//  Created by vishal on 4/18/23.
//

import Foundation

public protocol NetworkProviderProtocol {
    func request<T: Decodable>(dataType: T.Type, service: NetworkService) async throws -> T
}

public struct NetworkProvider: NetworkProviderProtocol {
    
    private let session: SessionProtocol
    
    public init(session: SessionProtocol = Session()) {
        self.session = session
    }
    
    public func request<T: Decodable>(dataType: T.Type, service: NetworkService) async throws -> T {
        return try await session.dataTask(service.urlRequest, dataType: dataType)
    }
}

