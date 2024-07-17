//
//  SearchBar.swift
//  TheMovieDB
//
//  Created by alfian on 09/07/24.
//

import UIKit
import SwiftUI

public struct SearchBar: UIViewRepresentable {
    @Binding var text: String

  public class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String

    init(text: Binding<String>) {
        _text = text
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
    }
  }

  public func makeCoordinator() -> Coordinator {
    return Coordinator(text: $text)
  }

  public func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar()
    searchBar.delegate = context.coordinator
    searchBar.placeholder = "Input at least 4 character"
    return searchBar
  }

  public func updateUIView(_ uiView: UISearchBar, context: Context) {
    uiView.text = text
  }
}
