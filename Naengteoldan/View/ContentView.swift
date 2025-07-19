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
    NavigationStack {
      IngredientListView(modelData: modelData)
        .allowsHitTesting(!modelData.isLoading)
        .overlay {
          LoadingView(isReceiptReady: $modelData.isLoading)
            .glassEffect(.regular, in: Rectangle())
            .ignoresSafeArea()
        }
        .fullScreenCover(item: $modelData.generatedRecipe) { recipe in
          RecipeDetailView(recipe: recipe, modelData: modelData)
            .background(.white)
            .presentationDragIndicator(.visible)
        }
    }
    .task {
      // pre-warm model
    }
  }
}


