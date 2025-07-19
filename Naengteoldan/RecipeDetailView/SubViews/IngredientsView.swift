//
//  IngredientsView.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

struct IngredientsView: View {
  let ingredients: [Ingredient]
  let animateCards: Bool
  
  var body: some View {
    VStack(spacing: DesignSystem.Spacing.medium) {
      ForEach(Array(ingredients.enumerated()), id: \.offset) { index, ingredient in
        HStack {
          Text(ingredient.icon!.rawValue)
            .font(DesignSystem.Typography.emojiSmall)
          
          Text(ingredient.name)
            .font(DesignSystem.Typography.body)
            .foregroundColor(.primary)
          
          Spacer()
        }
        .padding(.horizontal, DesignSystem.Spacing.extraLarge)
        .padding(.vertical, DesignSystem.Spacing.medium)
//        .background(
//          RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium)
//            .fill(.white)
//            .stroke(.black.opacity(0.7), lineWidth: 1)
//        )
        .glassEffect(.regular,
                     in: RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium)
                     )
        .opacity(animateCards ? 1 : 0)
        .animation(DesignSystem.Animation.spring.delay(Double(index) * 0.1), value: animateCards)
      }
    }
  }
}

#Preview {
  IngredientsView(ingredients: [.init(name: "asdf", icon: .apple)], animateCards: false)
}
