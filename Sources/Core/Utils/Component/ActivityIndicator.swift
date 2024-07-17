//
//  ActivityIndicator.swift
//  TheMovieDB
//
//  Created by alfian on 08/07/24.
//

import SwiftUI
import UIKit

public struct ActivityIndicator: UIViewRepresentable {
  @Binding var isAnimating: Bool

  public func makeUIView(context: Context) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    return indicator
  }

  public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    if isAnimating {
      uiView.startAnimating()
    } else {
      uiView.stopAnimating()
    }
  }
}

public struct ProgressView: UIViewRepresentable {

  public func makeUIView(context: Context) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    return indicator
  }

  public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {

  }
}
