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
            DesignSystem.Colors.primaryButtonGradient
          } else {
            Color.clear
          }
        }
      )
      .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large - 2))
    }
    .buttonStyle(PlainButtonStyle())
  }
}
