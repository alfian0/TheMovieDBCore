//
//  URLSessionClientTest.swift
//  
//
//  Created by alfian on 17/07/24.
//

import XCTest
import Combine
import TheMovieDBCore

final class URLSessionClientTest: XCTestCase {
  var session: HTTPClient!
  var cancellables: Set<AnyCancellable> = []
  let apiKey = ""

  override func setUp() {
    super.setUp()
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let client = URLSession(configuration: configuration)
    session = AuthenticatedHTTPClient(client: client, apiKey: apiKey)
  }

  override func tearDown() {
      MockURLProtocol.requestHandler = nil
      session = nil
      cancellables.removeAll()
      super.tearDown()
  }
  
  func testPublisherReturnsDataAndResponse() {
    let expectedData = "test data".data(using: .utf8)!
    
    MockURLProtocol.requestHandler = { request in
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        return (response, expectedData)
    }
    
    let url = URL(string: "https://example.com")!
    let request = URLRequest(url: url)
    let expectation = self.expectation(description: "Publisher completes")
    var receivedData: Data?
    
    session.publisher(request: request)
        .sink { _ in
          
        } receiveValue: { data, response in
          receivedData = data
          expectation.fulfill()
        }
        .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 1.0)
    
    XCTAssertEqual(receivedData, expectedData)
  }
  
  func testPublisherReturnsError() {
    let expectedError = URLError(.badServerResponse)
    MockURLProtocol.requestHandler = { _ in
      throw expectedError
    }
    
    let url = URL(string: "https://example.com")!
    let request = URLRequest(url: url)
    let expectation = self.expectation(description: "Publisher completes")
    var receivedError: Error?
    
    session.publisher(request: request)
        .sink { completion in
          if case let .failure(error) = completion {
            receivedError = error
          }
          expectation.fulfill()
        } receiveValue: { _ in
          
        }
        .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 1.0)
  
    XCTAssertEqual(receivedError!.localizedDescription, expectedError.localizedDescription)
  }
}
