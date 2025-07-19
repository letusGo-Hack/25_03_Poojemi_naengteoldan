//
//  IngredientList.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct IngredientList: View {
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

  var body: some View {
    ScrollView {
      LazyVGrid(columns: Array(repeating: GridItem(spacing: 16), count: 3), spacing: 16) {
        ForEach(ingredients) { ingredient in
          Button {
            if selection.contains(ingredient) {
              selection.remove(ingredient)
            } else {
              selection.insert(ingredient)
            }
          } label: {
            VStack(spacing: 4) {
              if let icon = ingredient.icon {
                Text(icon.rawValue)
                  .font(.system(size: 32))
              }
              Text(ingredient.name)
                .foregroundStyle(selection.contains(ingredient) ? .white : .secondary)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity)
            }
            .padding(12)
          }
          .glassEffect(
            selection.contains(ingredient) ?
              .regular.interactive().tint(.accentColor) :
                .regular.interactive()
          )
          .buttonStyle(.plain)
        }
      }
      .padding(16)
    }
    .background(
      Color(uiColor: .systemGroupedBackground)
//      MeshGradient(width: 2, height: 2, points: [
//        [0, 0], [1, 0],
//        [0, 1], [1, 1]
//      ], colors: [
//        .pink, .indigo,
//        .indigo, .blue
//      ])
//      .ignoresSafeArea()
    )
    .safeAreaBar(edge: .bottom) {
      recipeGenerateButton
        .disabled(selection.isEmpty)
        .padding(.bottom)
    }
    .navigationTitle("냉장고")
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
