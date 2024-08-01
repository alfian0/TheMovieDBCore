//
//  File.swift
//  
//
//  Created by alfian on 01/08/24.
//

import Foundation

public protocol CrashManager {
    func log(message: String)
    func setUserId(_ userId: String)
    func setCustomValue(_ value: Any, forKey key: String)
}

public class DefaultCrashManager: CrashManager {
    private var services: [CrashManager]
    
    // Singleton instance
    public static let shared = DefaultCrashManager(services: [])
    
    // Private initializer to prevent creating additional instances
    private init(services: [CrashManager]) {
        self.services = services
    }
    
    // Method to update services dynamically
    public func updateServices(_ services: [CrashManager]) {
        self.services = services
    }
    
    public func log(message: String) {
        services.forEach { $0.log(message: message) }
    }
    
    public func setUserId(_ userId: String) {
        services.forEach { $0.setUserId(userId) }
    }
    
    public func setCustomValue(_ value: Any, forKey key: String) {
        services.forEach { $0.setCustomValue(value, forKey: key) }
    }
}
