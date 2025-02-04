//
//  Utils.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

public class Utils {
  public static let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    return jsonDecoder
  }()

  public static let dateFormatter: DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-mm-dd"
    return dateFormater
  }()

  public static let yearFormatter: DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy"
    return dateFormater
  }()
}
