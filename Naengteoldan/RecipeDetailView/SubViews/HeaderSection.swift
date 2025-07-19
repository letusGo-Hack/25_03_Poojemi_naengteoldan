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
    ZStack(alignment: .bottom) {
      Image("FoodSample")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(contentMode: .fill)
        .opacity(0.8)

      VStack(spacing: DesignSystem.Spacing.large) {
        // 레시피 이름
        Text(recipeName)
//          .font(DesignSystem.Typography.largeTitle)
          .font(.system(size: 100))
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .scaleEffect(animateHeader ? 1 : 0.5)
          .animation(DesignSystem.Animation.springSlow.delay(0.2), value: animateHeader)
      }
      .padding(.vertical, DesignSystem.Spacing.massive)
    }
    .frame(height: 300)
    .frame(maxWidth: .infinity)
    .background(.black)
    .clipShape(
      .rect(
        topLeadingRadius: 0,
        topTrailingRadius: 0
      )
    )
  }
}

#Preview {
  HeaderSection(recipeName: "요리 제목", animateHeader: true)
}
