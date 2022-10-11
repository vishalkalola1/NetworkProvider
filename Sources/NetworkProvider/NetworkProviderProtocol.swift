//
//  NetworkProviderProtocol.swift
//  NetworkProvider
//
//  Created by Vishal on 11/10/2022.
//

import Foundation

public protocol NetworkProviderProtocol {    
    func request<T: Decodable>(
        dataType: T.Type,
        service: NetworkService,
        onQueue: DispatchQueue,
        completion: @escaping (Result<T, Swift.Error>) -> Void
    )
}
