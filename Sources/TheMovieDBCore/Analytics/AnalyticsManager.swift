//
//  File.swift
//  
//
//  Created by alfian on 31/07/24.
//

import Foundation

public protocol AnalyticsService {
  func logEvent(_ name: String, parameters: [String: Any]?)
  func setUserId(_ userId: String)
  func setUserProperty(_ name: String, value: String)
}


public protocol AnalyticsManager {
  func logEvent(_ name: String, parameters: [String: Any]?)
  func setUserId(_ userId: String)
  func setUserProperty(_ name: String, value: String)
}

public class DefaultAnalyticsManager: AnalyticsManager {
    private var services: [AnalyticsService]
    
    // Singleton instance
    public static let shared = DefaultAnalyticsManager(services: [])
    
    // Private initializer to prevent creating additional instances
    private init(services: [AnalyticsService]) {
        self.services = services
    }
    
    // Method to update services dynamically
    public func updateServices(_ services: [AnalyticsService]) {
        self.services = services
    }
    
    public func logEvent(_ name: String, parameters: [String: Any]?) {
        services.forEach { $0.logEvent(name, parameters: parameters) }
    }
    
    public func setUserId(_ userId: String) {
        services.forEach { $0.setUserId(userId) }
    }
    
    public func setUserProperty(_ name: String, value: String) {
        services.forEach { $0.setUserProperty(name, value: value) }
    }
}

