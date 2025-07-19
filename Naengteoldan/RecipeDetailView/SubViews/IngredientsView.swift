//
//  IngredientsView.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

struct IngredientsView: View {
  let ingredients: [String]
  let animateCards: Bool
  
  var body: some View {
    VStack(spacing: DesignSystem.Spacing.medium) {
      ForEach(Array(ingredients.enumerated()), id: \.offset) { index, ingredient in
        HStack {
          Text("🌟")
            .font(DesignSystem.Typography.emojiSmall)
          
          Text(ingredient)
            .font(DesignSystem.Typography.body)
            .foregroundColor(.primary)
          
          Spacer()
        }
        .padding(.horizontal, DesignSystem.Spacing.extraLarge)
        .padding(.vertical, DesignSystem.Spacing.medium)
        .background(
          RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium)
            .fill(DesignSystem.Colors.ingredientBackground)
            .stroke(DesignSystem.Colors.ingredientBorder, lineWidth: 1)
        )
        .scaleEffect(animateCards ? 1 : 0.5)
        .opacity(animateCards ? 1 : 0)
        .animation(DesignSystem.Animation.spring.delay(Double(index) * 0.1), value: animateCards)
      }
    }
  }
}

