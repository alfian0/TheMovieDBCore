//
//  File.swift
//  
//
//  Created by alfian on 31/07/24.
//

import Foundation

public protocol DeepLink {
  var path: String { get }
  func handle(url: URL)
}

public protocol DeepLinkManager {
  func handleDeepLink(url: URL)
}

public class DefaultDeepLinkManager: DeepLinkManager {
  
  // Static shared instance
  public static let shared = DefaultDeepLinkManager()
  
  // Private array to hold deep links
  private var deepLinks: [DeepLink] = []
  
  // Private initializer to prevent multiple instances
  private init() {}
  
  // Method to set deep links, if needed
  public func setDeepLinks(_ deepLinks: [DeepLink]) {
    self.deepLinks = deepLinks
  }
  
  // Method to handle deep links
  public func handleDeepLink(url: URL) {
    guard let deepLink = deepLinks.first(where: { $0.path == url.host }) else {
      print("No handler for URL: \(url)")
      return
    }
    deepLink.handle(url: url)
  }
}
