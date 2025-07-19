//
//  IngredientList.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct IngredientListView: View {
  @State private var ingredients: [Ingredient] = [
    Ingredient(name: "계란", icon: .egg),
    Ingredient(name: "우유", icon: .milk),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread),
    Ingredient(name: "밀가루", icon: .bread)
  ]

  @State private var selection = Set<Ingredient>()
  @State private var isAddIngredientViewPresented = false
  
  @Bindable var modelData: RecipeGeneratorViewModel

  var body: some View {
    ScrollView {
      LazyVGrid(columns: Array(repeating: GridItem(spacing: 16), count: 3), spacing: 16) {
        ForEach(ingredients) { ingredient in
          IngredientListItem(ingredient: ingredient, selection: $selection)
        }
      }
      .padding(16)
    }
    .background(
      Color(uiColor: .systemGroupedBackground)
    )
    .safeAreaBar(edge: .bottom) {
      recipeGenerateButton
        .disabled(selection.isEmpty)
        .padding(.bottom)
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button("추가", systemImage: "plus") {
          isAddIngredientViewPresented = true
        }
      }
    }
    .sheet(isPresented: $isAddIngredientViewPresented) {
      NavigationStack {
        AddIngredientView(ingredients: $ingredients)
      }
    }
    .opacity(modelData.isLoading ? 0.2 : 1)
    .animation(.easeInOut, value: modelData.isLoading)
    .overlay {
      LoadingView(isReceiptReady: $modelData.isLoading)
    }
  }

  private var recipeGenerateButton: some View {
    Button(role: .confirm) {
      print(selection)
      Task {
        await self.modelData.performRecipeGeneration(gradient: selection.map { $0.name })
      }
    } label: {
      Label("AI 레시피 추천", systemImage: "apple.intelligence")
        .foregroundStyle(
          MeshGradient(width: 2, height: 2, points: [
            [0, 0], [1, 0],
            [0, 1], [1, 1]
          ], colors: [
            .pink, .indigo,
            .indigo, .blue
          ])
        )
        .padding(8)
        .fontWeight(.semibold)
    }
    .buttonStyle(.glass)
  }
}

