//
//  IngredientListItem.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import SwiftUI

struct IngredientListItem: View {
  let ingredient: Ingredient
  @Binding var selection: Set<Ingredient>
  
  var body: some View {
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

#Preview {
  ContentView()
}
