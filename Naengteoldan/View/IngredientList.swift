//
//  IngredientList.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct IngredientList: View {
  @State private var ingredients: [Ingredient] = [
    Ingredient(name: "계란"),
    Ingredient(name: "우유"),
    Ingredient(name: "밀가루")
  ]

  @State private var selection = Set<UUID>()

  var body: some View {
    List(selection: $selection) {
      ForEach(ingredients) { ingredient in
        Text(ingredient.name)
      }
    }
    .environment(\.editMode, .constant(.active))
    .safeAreaBar(edge: .bottom) {
      recipeGenerateButton
        .disabled(selection.isEmpty)
        .padding(.bottom)
    }
    .navigationTitle("식재료 목록")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button("추가", systemImage: "plus") {

        }
      }
    }
  }

  private var recipeGenerateButton: some View {
    Button(role: .confirm) {

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

#Preview {
  ContentView()
}


