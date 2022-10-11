//
//  NetworkProvider.swift
//  NetworkProvider
//
//  Created by Vishal on 8/18/22.
//

import Foundation

public struct NetworkProvider: NetworkProviderProtocol {
    
    private let session: SessionProtocol
    
    public init(session: SessionProtocol = Session()) {
        self.session = session
    }
    
    public func request<T>(dataType: T.Type, service: NetworkService, onQueue: DispatchQueue, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let task = session.dataTask(service.urlRequest, dataType: dataType) { result in
            onQueue.async {
                completion(result)
            }
        }
        task.resume()
    }
}
