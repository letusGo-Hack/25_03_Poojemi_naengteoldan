//
//  AddIngredientView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct AddIngredientView: View {
  @State private var name = ""
  @State private var icon: IngredientIcon?

  var body: some View {
    VStack(spacing: 16) {
      TextField("재료 이름", text: $name)
        .padding(16)
        .fontWeight(.semibold)
        .multilineTextAlignment(.center)
        .glassEffect()

      ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
          ForEach(IngredientIcon.allCases, id: \.hashValue) { icon in
            Button {

            } label: {
              Text(icon.rawValue)
                .font(.system(size: 32))
                .padding(16)
                .glassEffect()
            }
          }
        }
        .padding(.vertical, 8)
      }
      Button {

      } label: {
        Text("재료 추가")
          .fontWeight(.semibold)
          .padding(.vertical, 8)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.glassProminent)
    }
    .frame(maxHeight: .infinity)
    .padding(16)
    .presentationDetents([.medium])
  }
}

#Preview {
  AddIngredientView()
}
