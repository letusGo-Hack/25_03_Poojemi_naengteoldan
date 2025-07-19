//
//  InstructionsView.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

struct InstructionsView: View {
  let instructions: [String]
  let animateCards: Bool
  
  var body: some View {
    VStack(spacing: DesignSystem.Spacing.large) {
      ForEach(Array(instructions.enumerated()), id: \.offset) { index, instruction in
        HStack(alignment: .top, spacing: DesignSystem.Spacing.medium) {
          // 단계 번호
          ZStack {
            Circle()
              .fill(DesignSystem.Colors.stepNumberGradient)
              .frame(width: DesignSystem.Size.iconMedium, height: DesignSystem.Size.iconMedium)
            
            Text("\(index + 1)")
              .font(DesignSystem.Typography.stepNumber)
              .foregroundColor(.white)
          }
          
          Text(instruction)
            .font(DesignSystem.Typography.body)
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
          
          Spacer(minLength: 0)
        }
        .padding(.horizontal, DesignSystem.Spacing.extraLarge)
        .padding(.vertical, DesignSystem.Spacing.large)
        .background(
          RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large)
            .fill(DesignSystem.Colors.instructionBackground)
            .stroke(DesignSystem.Colors.instructionBorder, lineWidth: 1)
        )
        .scaleEffect(animateCards ? 1 : 0.5)
        .opacity(animateCards ? 1 : 0)
        .animation(DesignSystem.Animation.spring.delay(Double(index) * 0.15), value: animateCards)
      }
    }
  }
}
