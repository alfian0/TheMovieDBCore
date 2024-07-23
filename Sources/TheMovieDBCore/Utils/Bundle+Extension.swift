//
//  Bundle+Extension.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation
import CoreData

extension Bundle {
  public func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D {
    guard let url = self.url(forResource: filename, withExtension: "json") else {
      throw NSError(domain: "FileNotFound",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "File \(filename).json not found in bundle."])
    }
    let data = try Data(contentsOf: url)
    let jsonDecoder = Utils.jsonDecoder
    let decodeModel = try jsonDecoder.decode(D.self, from: data)
    return decodeModel
  }
  
  public func loadNSPersistentContainer(filename: String) throws -> NSPersistentContainer {
    guard let url = self.url(forResource: filename, withExtension: "momd") else {
      throw NSError(domain: "FileNotFound",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "File \(filename).json not found in bundle."])
    }
    let managedObjectModel =  NSManagedObjectModel(contentsOf: url)!
    let container = NSPersistentContainer(name: filename, managedObjectModel: managedObjectModel)
    return container
  }
}
