//
//  DefaultDTOMapperTest.swift
//  
//
//  Created by alfian on 17/07/24.
//

import XCTest
import TheMovieDBCore

final class DefaultDTOMapperTest: XCTestCase {
  struct MockData: Codable, Equatable {
      let id: Int
      let name: String
  }
  
  let mockJSON = """
  {
      "id": 1,
      "name": "Test"
  }
  """.data(using: .utf8)!
  
  func testMapSuccessfullyDecodesData() throws {
    let response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                   statusCode: 200,
                                   httpVersion: nil,
                                   headerFields: nil)!
    
    let result: MockData = try DefaultDTOMapper.map(data: mockJSON, response: response)
    
    let expected = MockData(id: 1, name: "Test")
    
    XCTAssertEqual(result, expected)
  }
  
  func testMapThrowsErrorForInvalidStatusCode() {
    let response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                   statusCode: 404,
                                   httpVersion: nil,
                                   headerFields: nil)!
    
    if let result: MockData = try? DefaultDTOMapper.map(data: mockJSON, response: response) {
      XCTAssertThrowsError(result) { error in
          XCTAssertEqual(error as? MovieNetworkError, .invalidResponse)
      }
    }
  }
  
  func testMapThrowsErrorForInvalidData() {
    let invalidJSON = "invalid data".data(using: .utf8)!
    let response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                   statusCode: 200,
                                   httpVersion: nil,
                                   headerFields: nil)!
    
    if let result: MockData = try? DefaultDTOMapper.map(data: invalidJSON, response: response) {
      XCTAssertThrowsError(result) { error in
          XCTAssertTrue(error is DecodingError)
      }
    }
  }
}
