//
//  File.swift
//  
//
//  Created by alfian on 31/07/24.
//

import Foundation

public protocol DeepLink {
  var url: URL { get }
  func handle()
}

public protocol DeepLinkManager {
  func handleDeepLink(url: URL)
}

public class DefaultDeepLinkManager: DeepLinkManager {
  private var deepLinks: [DeepLink] = []
    
  public init(deepLinks: [DeepLink]) {
    self.deepLinks = deepLinks
  }
    
  public func handleDeepLink(url: URL) {
    guard let deepLink = deepLinks.first(where: { $0.url.host == url.host }) else {
      print("No handler for URL: \(url)")
      return
    }
    deepLink.handle()
  }
}
