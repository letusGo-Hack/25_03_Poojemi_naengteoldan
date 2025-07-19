//
//  HeaderSection.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

struct HeaderSection: View {
  let recipeName: String
  let animateHeader: Bool
  
  var body: some View {
    ZStack {
      // 그라데이션 배경
      DesignSystem.Colors.headerGradient
      
      // 장식적 도형들
      GeometryReader { geometry in
        ForEach(0..<6, id: \.self) { index in
          Circle()
            .fill(DesignSystem.Colors.whiteOverlay)
            .frame(width: CGFloat.random(in: 30...80))
            .position(
              x: CGFloat.random(in: 0...geometry.size.width),
              y: CGFloat.random(in: 0...geometry.size.height)
            )
            .scaleEffect(animateHeader ? 1 : 0)
            .animation(DesignSystem.Animation.spring.delay(Double(index) * 0.1), value: animateHeader)
        }
      }
      
      VStack(spacing: DesignSystem.Spacing.large) {
        // 요리 이모지
        Text("🍳")
          .font(DesignSystem.Typography.emojiLarge)
          .scaleEffect(animateHeader ? 1 : 0)
          .rotationEffect(.degrees(animateHeader ? 0 : 180))
          .animation(DesignSystem.Animation.spring, value: animateHeader)
        
        // 레시피 이름
        Text(recipeName)
          .font(DesignSystem.Typography.largeTitle)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .shadow(
            color: DesignSystem.Shadow.text.color,
            radius: DesignSystem.Shadow.text.radius,
            x: DesignSystem.Shadow.text.x,
            y: DesignSystem.Shadow.text.y
          )
          .scaleEffect(animateHeader ? 1 : 0.5)
          .animation(DesignSystem.Animation.springSlow.delay(0.2), value: animateHeader)
      }
      .padding(.vertical, DesignSystem.Spacing.massive)
    }
    .frame(height: DesignSystem.Size.headerHeight)
    .clipShape(
      .rect(
        topLeadingRadius: 0,
        bottomLeadingRadius: DesignSystem.CornerRadius.extraLarge,
        bottomTrailingRadius: DesignSystem.CornerRadius.extraLarge,
        topTrailingRadius: 0
      )
    )
  }
}
