//
//  HTTPClient.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation
import Combine

public protocol HTTPClient {
  func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
