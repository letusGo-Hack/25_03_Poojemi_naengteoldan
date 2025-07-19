//
//  AddIngredientView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct AddIngredientView: View {
  @Binding var ingredients: [Ingredient]

  @State private var name = ""
  @State private var icon: IngredientIcon?
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack(spacing: 16) {
      TextField("재료 이름", text: $name)
        .padding(16)
        .fontWeight(.semibold)
        .multilineTextAlignment(.center)
        .glassEffect()
        .padding(.horizontal, 16)

      ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 16) {
          ForEach(IngredientIcon.allCases, id: \.hashValue) { icon in
            Button {
              self.icon = icon
            } label: {
              Text(icon.rawValue)
                .font(.system(size: 32))
                .padding(16)
                .glassEffect(self.icon == icon ? .regular.tint(.accentColor) : .regular)
            }
          }
        }
      }
      .scrollIndicators(.hidden)
      .padding(.horizontal, 16)

      Button {
        ingredients.append(Ingredient(name: name, icon: icon))
        dismiss()
      } label: {
        Text("재료 추가")
          .fontWeight(.semibold)
          .padding(.vertical, 8)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.glass)
      .padding(.horizontal, 16)
      .disabled(name.isEmpty)
    }
    .frame(maxHeight: .infinity)
    .padding(.vertical, 16)
    .presentationDetents([.medium])
    .presentationDragIndicator(.visible)
    .ignoresSafeArea(.container)
  }
}

