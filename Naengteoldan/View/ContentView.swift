//
//  ContentView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Tab {
        IngredientListView()
      } label: {
        Label("냉장고", systemImage: "refrigerator")
      }

      Tab {

      } label: {
        Label("즐겨찾기", systemImage: "heart")
      }
    }
  }
}

#Preview {
  ContentView()
}

