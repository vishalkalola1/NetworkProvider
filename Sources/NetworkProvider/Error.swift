//
//  Error.swift
//  NetworkProvider
//
//  Created by Vishal on 11/10/2022.
//

import Foundation

public enum Error: Swift.Error {
  case operationCancelled
  case requestFailed(error: Swift.Error)
  case unknownStatusCode
  case unexpectedStatusCode(code: Int)
  case contentEmptyData
  case contentDecoding(error: Swift.Error)
}

extension Error: CustomStringConvertible {
  public var description: String {
    switch self {
    case .operationCancelled:
      return "Operation was cancelled"
    case let .requestFailed(error):
      return "Request failed with \(error)"
    case .unknownStatusCode:
      return "The status code is unknown"
    case let .unexpectedStatusCode(error):
      return "The status code is unexpected \(error)"
    case .contentEmptyData:
      return "The contyent data is empty"
    case let .contentDecoding(error):
      return "Error while decoding with \(error)"
    }
  }
}
