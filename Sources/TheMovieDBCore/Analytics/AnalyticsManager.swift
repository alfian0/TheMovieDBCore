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
  
  public init(services: [AnalyticsService]) {
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
