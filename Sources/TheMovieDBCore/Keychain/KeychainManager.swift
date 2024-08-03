//
//  File.swift
//  
//
//  Created by alfian on 03/08/24.
//

import Foundation
import Security

public class KeychainManager {
    
  public static let shared = KeychainManager()
    
  private init() {}
  
  public func save(key: String, value: String) -> Bool {
    guard let data = value.data(using: .utf8) else { return false }
    
    // Create query for saving data
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key,
      kSecValueData as String: data
    ]
    
    // Delete any existing item with the same key
    SecItemDelete(query as CFDictionary)
    
    // Add new item to the keychain
    let status = SecItemAdd(query as CFDictionary, nil)
    
    return status == errSecSuccess
  }
  
  public func retrieve(key: String) -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key,
      kSecReturnData as String: kCFBooleanTrue!,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    var dataTypeRef: AnyObject? = nil
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    
    guard status == errSecSuccess, let data = dataTypeRef as? Data else { return nil }
    
    return String(data: data, encoding: .utf8)
  }
  
  public func delete(key: String) -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    
    return status == errSecSuccess
  }
  
  public func update(key: String, value: String) -> Bool {
    guard let data = value.data(using: .utf8) else { return false }
    
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key
    ]
    
    let attributes: [String: Any] = [
      kSecValueData as String: data
    ]
    
    let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
    
    return status == errSecSuccess
  }
}
