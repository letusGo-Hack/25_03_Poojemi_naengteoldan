//
//  ContentView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct ContentView: View {
  @State var modelData = RecipeGeneratorViewModel()
  
  var body: some View {
    TabView {
      Tab {
        NavigationStack {
          if let generatedRecipe = modelData.generatedRecipe {
            RecipeDetailView(recipe: generatedRecipe)
          } else {
            IngredientListView(modelData: modelData)
          }
        }
      } label: {
        Label("냉장고", systemImage: "refrigerator")
      }

      Tab {

      } label: {
        Label("즐겨찾기", systemImage: "heart")
      }
    }
    .task {
      // pre-warm model
    }
  }
}

#Preview {
  ContentView()
}

