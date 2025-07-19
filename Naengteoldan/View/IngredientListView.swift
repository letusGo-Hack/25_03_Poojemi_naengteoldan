//
//  IngredientListView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct IngredientListView: View {
  @Bindable var modelData: RecipeGeneratorViewModel

  private let columns = Array(repeating: GridItem(spacing: 16), count: 3)

  @State private var searchText = ""
  @State private var selection = Set<IngredientIcon>()
  @State private var isErrorDialogPresented = false

  private var ingredients: [IngredientIcon] {
    if searchText.isEmpty {
      IngredientIcon.allCases
    } else {
      IngredientIcon.allCases.filter {
        $0.name.localizedCaseInsensitiveContains(searchText)
        // $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }

  var body: some View {
    ZStack {
      if ingredients.isEmpty {
        Text("검색 결과가 없습니다.")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .foregroundStyle(.secondary)
      } else {
        ScrollView {
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(ingredients, id: \.hashValue) { icon in
              ingredientButton(icon)
            }
          }
          .padding(16)
        }
        .scrollIndicators(.hidden)
      }
    }
    .safeAreaInset(edge: .bottom) {
      generateRecipeButton
        .padding(.horizontal, 16)
        .opacity(selection.isEmpty ? 0 : 1)
        .offset(y: selection.isEmpty ? 100 : 0)
        .animation(.bouncy(duration: 0.3), value: selection.isEmpty)
    }
    .safeAreaInset(edge: .top) {
      searchField
        .padding(.horizontal, 16)
    }
    .confirmationDialog(
      "오류가 발생하였습니다.",
      isPresented: $isErrorDialogPresented,
      titleVisibility: .visible) {
        Button("확인") {
          isErrorDialogPresented = false
        }
      } message: {
        Text(modelData.errorMessage ?? "")
      }
      .onChange(of: modelData.errorMessage) { _, newValue in
        print("에러 발생")
        if newValue != nil {
          isErrorDialogPresented = true
        }
      }
  }

  @ViewBuilder
  private func ingredientButton(_ icon: IngredientIcon) -> some View {
    Button {
      if selection.contains(icon) {
        selection.remove(icon)
      } else {
        selection.insert(icon)
      }
    } label: {
      VStack(spacing: 4) {
        Text(icon.rawValue)
          .font(.system(size: 32))
        Text(icon.name)
          .font(.system(size: 12))
          .foregroundStyle(
            selection.contains(icon) ?
              .white :
                .secondary
          )
          .frame(maxWidth: .infinity)
      }
      .padding(16)
      .glassEffect(
        selection.contains(icon) ?
          .regular.interactive().tint(.accentColor) :
            .regular.interactive())
    }
  }

  private var searchField: some View {
    TextField("재료 검색", text: $searchText)
      .padding(16)
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
      .glassEffect()
  }

  private var generateRecipeButton: some View {
    Button {
      print(selection)
      modelData.userSelectedIngredient = selection.map { Ingredient(name: $0.name, icon: $0) }
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
        .fontWeight(.semibold)
        .padding(8)
        .frame(maxWidth: .infinity)
    }
    .buttonStyle(.glass)
    // .buttonStyle(.plain) // plain 금지
  }
}

