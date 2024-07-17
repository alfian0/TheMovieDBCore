//
//  GenericAPIHTTPRequestMapper.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation

// MARK:
// For separation of concern we separate Mapper on the diffrent class so we can change inplementation base on need
public protocol DTOMapper {
  static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable
}

public struct DefaultDTOMapper: DTOMapper {
  public static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable {
    if (200..<300) ~= response.statusCode {
      return try Utils.jsonDecoder.decode(T.self, from: data)
    }

    throw MovieNetworkError.invalidResponse
  }
}
