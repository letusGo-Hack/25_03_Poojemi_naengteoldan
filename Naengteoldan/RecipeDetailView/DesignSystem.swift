//
//  DesignSystem.swift
//  Naengteoldan
//
//  Created by Claude on 7/19/25.
//

import SwiftUI

// MARK: - Design System
enum DesignSystem {
  
  // MARK: - Typography
  enum Typography {
    static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
    static let title = Font.system(size: 20, weight: .bold, design: .rounded)
    static let headline = Font.system(size: 16, weight: .semibold, design: .rounded)
    static let body = Font.system(size: 15, weight: .medium, design: .rounded)
    static let caption = Font.system(size: 12, weight: .medium, design: .rounded)
    static let stepNumber = Font.system(size: 14, weight: .bold, design: .rounded)
    
    static let emojiLarge = Font.system(size: 60)
    static let emojiMedium = Font.system(size: 32)
    static let emojiSmall = Font.title2
    static let emojiTiny = Font.title3
  }
  
  // MARK: - Corner Radius
  enum CornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 15
    static let large: CGFloat = 20
    static let extraLarge: CGFloat = 30
  }
  
  // MARK: - Spacing
  enum Spacing {
    static let tiny: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let extraLarge: CGFloat = 20
    static let huge: CGFloat = 24
    static let massive: CGFloat = 60
  }
  
  // MARK: - Sizes
  enum Size {
    static let iconSmall: CGFloat = 16
    static let iconMedium: CGFloat = 30
    static let buttonHeight: CGFloat = 56
    static let headerHeight: CGFloat = 200
    static let cardMaxWidth: CGFloat = .infinity
    static let tabContentHeight: CGFloat = 400
  }
  
  // MARK: - Colors
  enum Colors {
    // Gradients
    static let headerGradient = LinearGradient(
      colors: [
        Color.pink.opacity(0.8),
        Color.orange.opacity(0.7),
        Color.yellow.opacity(0.6)
      ],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    
    static let primaryButtonGradient = LinearGradient(
      colors: [Color.pink, Color.orange],
      startPoint: .leading,
      endPoint: .trailing
    )
    
    static let stepNumberGradient = LinearGradient(
      colors: [Color.orange, Color.pink],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    
    // Liquid Glass Effects
    static let liquidGlassBackground = Color.white.opacity(0.15)
    static let liquidGlassBorder = Color.white.opacity(0.25)
    static let liquidGlassSelectedBackground = LinearGradient(
      colors: [
        Color.white.opacity(0.3),
        Color.white.opacity(0.1)
      ],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    
    // Semantic Colors
    static let cardBackground = Color.gray.opacity(0.1)
    static let whiteOverlay = Color.white.opacity(0.1)
    static let shadowColor = Color.black.opacity(0.3)
    
    // Feature Colors
    static let ingredientBackground = Color.green.opacity(0.1)
    static let ingredientBorder = Color.green.opacity(0.3)
    static let instructionBackground = Color.blue.opacity(0.05)
    static let instructionBorder = Color.blue.opacity(0.2)
    
    // Info Card Colors
    static let purpleCard = Color.purple
    static let redCard = Color.red
    static let blueCard = Color.blue
  }
  
  // MARK: - Shadows
  enum Shadow {
    static let text = (color: Color.black.opacity(0.3), radius: CGFloat(2), x: CGFloat(1), y: CGFloat(1))
    static let card = (radius: CGFloat(8), x: CGFloat(0), y: CGFloat(4))
  }
  
  // MARK: - Animation
  enum Animation {
    static let spring = SwiftUI.Animation.spring(response: 0.8, dampingFraction: 0.6)
    static let springSlow = SwiftUI.Animation.spring(response: 1.2, dampingFraction: 0.7)
    static let springFast = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let easeInOut = SwiftUI.Animation.easeInOut(duration: 0.2)
  }
  
  // MARK: - Opacity
  enum Opacity {
    static let overlay: Double = 0.1
    static let border: Double = 0.3
    static let background: Double = 0.05
    static let strong: Double = 0.8
    static let medium: Double = 0.6
    static let light: Double = 0.3
  }
}
