//
//  AlamofireClient.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Combine
import Alamofire

public final class AlamofireClient: HTTPClient {
  struct InvalidHTTPResponseError: Error {}

  public func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
    return Future<(Data, HTTPURLResponse), Error> { promise in
      AF.request(request)
        .validate()
        .response { result in
          if let data = result.data, let response = result.response {
            promise(.success((data, response)))
          } else {
            promise(.failure(InvalidHTTPResponseError()))
          }
        }
    }
    .eraseToAnyPublisher()
  }
}

public final class AlamofireAuthenticatedClient: HTTPClient {
  private let client: HTTPClient
  private let apiKey: String

  init(client: HTTPClient = AlamofireClient(), apiKey: String) {
    self.client = client
    self.apiKey = apiKey
  }

  public func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
    var signedRequest = request
    signedRequest.url = appendApiKey(to: request.url)
    return client.publisher(request: signedRequest)
  }

  private func appendApiKey(to url: URL?) -> URL? {
    guard let url = url,
          var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      return url
    }
    var queryItems = urlComponents.queryItems ?? []
    queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
    urlComponents.queryItems = queryItems
    return urlComponents.url
  }
}
