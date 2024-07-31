//
//  File.swift
//  
//
//  Created by alfian on 31/07/24.
//

import UIKit

public protocol Coordinator {
  var childCoordinator: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}
