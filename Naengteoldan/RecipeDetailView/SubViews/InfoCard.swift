//
//  InfoCard.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

struct InfoCard: View {
  let icon: String
  let title: String
  let value: String
  let color: Color
  
  var body: some View {
    VStack(spacing: DesignSystem.Spacing.small) {
      Text(icon)
        .font(DesignSystem.Typography.emojiMedium)
      
      Text(title)
        .font(DesignSystem.Typography.caption)
        .foregroundColor(.secondary)
      
      Text(value)
        .font(DesignSystem.Typography.body)
        .foregroundColor(.primary)
    }
    .frame(maxWidth: DesignSystem.Size.cardMaxWidth)
    .padding(.vertical, DesignSystem.Spacing.large)
    .background(
      RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium)
        .fill(color.opacity(DesignSystem.Opacity.overlay))
        .stroke(color.opacity(DesignSystem.Opacity.border), lineWidth: 1)
    )
  }
}

