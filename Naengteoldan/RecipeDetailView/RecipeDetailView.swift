//
//  RecipeDetailView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import SwiftUI

struct RecipeDetailView: View {
  let recipe: Recipe
  @State private var animateHeader = false
  @State private var animateCards = false
  
  var body: some View {
    VStack {
      VStack(spacing: 0) {
        HeaderSection(recipeName: recipe.name, animateHeader: animateHeader)
        
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
          InstructionsView(instructions: recipe.instructions, animateCards: animateCards)
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

struct SampleView: View {
  var body: some View {
    RecipeDetailView(recipe: Recipe(
      name: "매콤한 제육볶음",
      ingredients: [
        "대패삼겹살 300g",
        "대파 2대",
        "양파 1개",
        "설탕 1큰술",
        "고추장 2큰술",
        "간장 1큰술",
        "마늘 3쪽",
        "생강 1조각"
      ],
      instructions: [
        "대패삼겹살을 한입 크기로 자르고, 양파와 대파도 적당한 크기로 썰어주세요.",
        "마늘과 생강을 다져서 준비해주세요.",
        "팬에 기름을 두르고 중불에서 대패삼겹살을 볶아주세요.",
        "고기가 익으면 마늘, 생강, 양파를 넣고 함께 볶아주세요.",
        "고추장, 간장, 설탕을 넣고 골고루 섞어가며 볶아주세요.",
        "마지막에 대파를 넣고 살짝 볶아 완성해주세요.마지막에 대파를 넣고 살짝 볶아 완성해주세요.마지막에 대파를 넣고 살짝 볶아 완성해주세요.마지막에 대파를 넣고 살짝 볶아 완성해주세요.마지막에 대파를 넣고 살짝 볶아 완성해주세요.마지막에 대파를 넣고 살짝 볶아 완성해주세요.마지막에 대파를 넣고 살짝 볶아 완성해주세요."
      ],
      prepTime: "15분",
      cookTime: "20분",
      servings: "2-3인분"
    ))
  }
}

#Preview {
  SampleView()
}
