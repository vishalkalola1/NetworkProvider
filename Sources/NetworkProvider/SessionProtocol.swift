//
//  SessionProtocol.swift
//  NetworkProvider
//
//  Created by Vishal on 11/10/2022.
//

import Foundation

public protocol SessionProtocol {
    func dataTask<T: Decodable>( _ request: URLRequest, dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask
}

