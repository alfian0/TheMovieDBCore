//
//  RequestTests.swift
//  
//
//  Created by alfian on 17/07/24.
//

import XCTest
import TheMovieDBCore

final class RequestTests: XCTestCase {
  struct MockRequest: Request {
    var path: String
    var method: HTTPMethod
    var contentType: String
    var body: [String: Any]?
    var queryParams: [String: Any]?
    var headers: [String: String]?
    typealias ReturnType = MockResponse
  }

  struct MockResponse: Codable {
    let id: Int
    let name: String
  }
  
  func testAsURLRequestWithGetRequest() {
    let request = MockRequest(
      path: "/test",
      method: .get,
      contentType: ContentType.json.rawValue,
      body: nil,
      queryParams: ["key": "value"],
      headers: ["Authorization": "Bearer token"]
    )
    
    let baseURL = "https://example.com"
    
    let urlRequest = request.asURLRequest(baseURL: baseURL)
    
    XCTAssertNotNil(urlRequest)
    XCTAssertEqual(urlRequest?.url?.absoluteString, "https://example.com/test?key=value")
    XCTAssertEqual(urlRequest?.httpMethod, "GET")
    XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue), ContentType.json.rawValue)
    XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "Authorization"), "Bearer token")
  }
  
  func testAsURLRequestWithPostRequest() {
    let requestBody: [String : Any] = ["id": 123, "name": "Test"]
    let request = MockRequest(
      path: "/test",
      method: .post,
      contentType: ContentType.json.rawValue,
      body: requestBody,
      queryParams: nil,
      headers: ["Authorization": "Bearer token"]
    )
    
    let baseURL = "https://example.com"
    
    let urlRequest = request.asURLRequest(baseURL: baseURL)
    
    XCTAssertNotNil(urlRequest)
    XCTAssertEqual(urlRequest?.url?.absoluteString, "https://example.com/test")
    XCTAssertEqual(urlRequest?.httpMethod, "POST")
    XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue), ContentType.json.rawValue)
    XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "Authorization"), "Bearer token")
    XCTAssertEqual(urlRequest?.httpBody, try? JSONSerialization.data(withJSONObject: requestBody, options: []))
  }
  
  func testAsURLRequestWithNoQueryParamsAndBody() {
    let request = MockRequest(
      path: "/test",
      method: .get,
      contentType: ContentType.json.rawValue,
      body: nil,
      queryParams: nil,
      headers: nil
    )
    
    let baseURL = "https://example.com"
    
    let urlRequest = request.asURLRequest(baseURL: baseURL)
    
    XCTAssertNotNil(urlRequest)
    XCTAssertEqual(urlRequest?.url?.absoluteString, "https://example.com/test")
    XCTAssertEqual(urlRequest?.httpMethod, "GET")
    XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue), ContentType.json.rawValue)
  }
  
  func testAsURLRequestWithInvalidBaseURL() {
    let request = MockRequest(
      path: "/test",
      method: .get,
      contentType: ContentType.json.rawValue,
      body: nil,
      queryParams: nil,
      headers: nil
    )
    
    let baseURL = "invalid url"
    
    let urlRequest = request.asURLRequest(baseURL: baseURL)
    
    XCTAssertNil(urlRequest)
  }
}
