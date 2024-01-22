//
//  RechabilityProvider.swift
//  KLMAssigment
//
//  Created by vishal on 4/18/23.
//

import Foundation
import Reachability

public protocol RechabilityProviderProtocol: AnyObject {
    func checkInternetAvailabel() -> Bool
}

public class RechabilityProvider: RechabilityProviderProtocol {
    
    private let reachability = try! Reachability()
    
    public init() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    public func checkInternetAvailabel() -> Bool {
        return reachability.connection != .unavailable
    }
}
