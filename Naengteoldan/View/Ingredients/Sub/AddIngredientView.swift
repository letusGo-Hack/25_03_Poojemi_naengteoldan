//
//  AddIngredientView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct AddIngredientView: View {
  @Binding var ingredients: [Ingredient]

  private let columns = Array(repeating: GridItem(spacing: 16), count: 3)
  @State private var searchText = ""
  @State private var selection = Set<IngredientIcon>()
  @Environment(\.dismiss) private var dismiss

  private var icons: [IngredientIcon] {
    if searchText.isEmpty {
      IngredientIcon.allCases
    } else {
      IngredientIcon.allCases.filter {
        $0.name.localizedCaseInsensitiveContains(searchText)
        //        $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }

  var body: some View {
    ZStack {
      if icons.isEmpty {
        Text("검색 결과가 없습니다.")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .foregroundStyle(.secondary)
      } else {
        ScrollView {
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(icons, id: \.hashValue) { icon in
              ingredientButton(icon)
            }
          }
          .padding(16)
        }
        .scrollIndicators(.hidden)
      }
    }
    .safeAreaInset(edge: .bottom) {
      addButton
        .padding(.horizontal, 16)
        .opacity(selection.isEmpty ? 0 : 1)
        .offset(y: selection.isEmpty ? 100 : 0)
        .animation(.bouncy(duration: 0.3), value: selection.isEmpty)
    }
    .safeAreaInset(edge: .top) {
      searchField
        .padding(.horizontal, 16)
        .padding(.top, 16 + 8)
    }
    .frame(maxHeight: .infinity)
    .presentationDetents([.large])
    .presentationDragIndicator(.visible)
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
    // .buttonStyle(.plain) // plain 금지
  }

  private var searchField: some View {
    TextField("재료 검색", text: $searchText)
      .padding(16)
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
      .glassEffect()
  }

  private var addButton: some View {
    Button {
      let newIngredients = selection.map {
        Ingredient(name: $0.name, icon: $0)
      }
      ingredients.append(contentsOf: newIngredients)
      dismiss()
    } label: {
      Text("재료 추가")
        .fontWeight(.semibold)
        .padding(16)
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .glassEffect(.regular.interactive().tint(.accentColor))
    }
    // .buttonStyle(.plain) // plain 금지
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var isPresented = true

  VStack {

  }
  .sheet(isPresented: .constant(true)) {
    AddIngredientView(ingredients: .constant([]))
  }
}


