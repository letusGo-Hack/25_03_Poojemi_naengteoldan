//
//  TabButton.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

struct TabButton: View {
  let title: String
  let icon: String
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack(spacing: DesignSystem.Spacing.small) {
        Text(icon)
          .font(DesignSystem.Typography.emojiTiny)
        
        Text(title)
          .font(DesignSystem.Typography.headline)
      }
      .foregroundColor(isSelected ? .white : .primary)
      .frame(maxWidth: DesignSystem.Size.cardMaxWidth)
      .padding(.vertical, DesignSystem.Spacing.medium)
      .background(
        Group {
          if isSelected {
            // Liquid glass selected state
            DesignSystem.Colors.liquidGlassSelectedBackground
              .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large - 2)
                  .stroke(DesignSystem.Colors.liquidGlassBorder, lineWidth: 1)
              )
              .shadow(
                color: DesignSystem.Colors.shadowColor.opacity(0.1),
                radius: DesignSystem.Shadow.card.radius,
                x: DesignSystem.Shadow.card.x,
                y: DesignSystem.Shadow.card.y
              )
          } else {
            // Liquid glass unselected state
            DesignSystem.Colors.liquidGlassBackground
              .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large - 2)
                  .stroke(DesignSystem.Colors.liquidGlassBorder, lineWidth: 0.5)
              )
          }
        }
      )
      .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large - 2))
    }
    .buttonStyle(PlainButtonStyle())
  }
}

#Preview {
  VStack {
    HStack(spacing: 0) {
      TabButton(title: "재료", icon: "🥕", isSelected: true) {}
      TabButton(title: "조리법", icon: "📝", isSelected: false) {}
    }
    .background(DesignSystem.Colors.cardBackground)
    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large))
    
    HStack(spacing: 0) {
      TabButton(title: "재료", icon: "🥕", isSelected: false) {}
      TabButton(title: "조리법", icon: "📝", isSelected: true) {}
    }
    .background(DesignSystem.Colors.cardBackground)
    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large))
  }
  .padding()
}
