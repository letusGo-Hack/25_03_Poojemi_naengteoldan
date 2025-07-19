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
//      .background(
//        Group {
//          if isSelected {
//            DesignSystem.Colors.primaryButtonGradient
//          } else {
//            Color.clear
//          }
//        }
//      )
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
