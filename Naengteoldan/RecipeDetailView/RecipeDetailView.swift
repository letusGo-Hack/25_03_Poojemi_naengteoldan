//
//  RecipeDetailView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import SwiftUI

struct RecipeDetailView: View {
  let recipe: RecipeItem
  @State private var animateHeader = false
  @State private var animateCards = false
  
  var body: some View {
    VStack {
      VStack(spacing: 0) {
        HeaderSection(recipeName: recipe.title, animateHeader: animateHeader)
        
        // 메인 콘텐츠
        recipeSectionsView
        .padding(.horizontal, DesignSystem.Spacing.extraLarge)
        .padding(.vertical, DesignSystem.Spacing.huge)
        .background(
          Rectangle()
            .fill(Color(.systemBackground))
            .shadow(
              color: DesignSystem.Shadow.text.color.opacity(0.1),
              radius: DesignSystem.Shadow.card.radius,
              x: DesignSystem.Shadow.card.x,
              y: -DesignSystem.Shadow.card.y
            )
        )
      }
    }
    .ignoresSafeArea(edges: .top)
    .onAppear {
      withAnimation(DesignSystem.Animation.spring) {
        animateHeader = true
      }
      withAnimation(DesignSystem.Animation.springSlow.delay(0.3)) {
        animateCards = true
      }
    }.padding(.bottom, 12)
  }
  
  
  // MARK: - Cooking Info Cards
  private var cookingInfoCards: some View {
    HStack(spacing: DesignSystem.Spacing.large) {
      if let prepTime = recipe.prepTime {
        InfoCard(icon: "⏱️", title: "준비시간", value: prepTime, color: DesignSystem.Colors.purpleCard)
      }
      
      if let cookTime = recipe.cookTime {
        InfoCard(icon: "🔥", title: "조리시간", value: cookTime, color: DesignSystem.Colors.redCard)
      }
      
      if let servings = recipe.servings {
        InfoCard(icon: "👥", title: "인분", value: servings, color: DesignSystem.Colors.blueCard)
      }
    }
    .scaleEffect(animateCards ? 1 : 0.8)
    .opacity(animateCards ? 1 : 0)
  }
  
  // MARK: - Recipe Sections View
  private var recipeSectionsView: some View {
    ScrollView {
      cookingInfoCards
      
      LazyVStack(spacing: DesignSystem.Spacing.huge, pinnedViews: [.sectionHeaders]) {
        // 재료 섹션
        Section {
          IngredientsView(ingredients: recipe.ingredients, animateCards: animateCards)
        } header: {
          SectionHeader(
            title: "재료",
            icon: "carrot.fill",
            animateCards: animateCards
          )
        }
        
        // 조리법 섹션
        Section {
          InstructionsView(instructions: recipe.directions, animateCards: animateCards)
        } header: {
          SectionHeader(
            title: "조리법",
            icon: "doc.text.fill",
            animateCards: animateCards
          )
        }
      }
    }
    .frame(height: DesignSystem.Size.tabContentHeight)
    .scaleEffect(animateCards ? 1 : 0.8)
    .opacity(animateCards ? 1 : 0)
  }
}

// MARK: - Section Header
struct SectionHeader: View {
  let title: String
  let icon: String
  let animateCards: Bool
  
  var body: some View {
    HStack(spacing: DesignSystem.Spacing.medium) {
      Image(systemName: icon)
        .font(DesignSystem.Typography.emojiSmall)
        .foregroundColor(.white)
      
      Text(title)
        .font(DesignSystem.Typography.title)
        .foregroundColor(.white)
      
      Spacer()
    }
    .padding(.horizontal, DesignSystem.Spacing.extraLarge)
    .padding(.vertical, DesignSystem.Spacing.large)
    .background(
      DesignSystem.Colors.liquidGlassSelectedBackground
        .overlay(
          Rectangle()
            .stroke(DesignSystem.Colors.liquidGlassBorder, lineWidth: 1)
        )
    )
    .shadow(
      color: DesignSystem.Colors.shadowColor.opacity(0.1),
      radius: DesignSystem.Shadow.card.radius,
      x: DesignSystem.Shadow.card.x,
      y: DesignSystem.Shadow.card.y
    )
    .scaleEffect(animateCards ? 1 : 0.8)
    .opacity(animateCards ? 1 : 0)
  }
}
