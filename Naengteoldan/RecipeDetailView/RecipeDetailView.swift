//
//  RecipeDetailView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import SwiftUI

struct RecipeDetailView: View {
  let recipe: RecipeItem
  @Bindable var modelData: RecipeGeneratorViewModel
  @State private var animateHeader = false
  @State private var animateCards = true
  
  var body: some View {
    ScrollView(.vertical) {
      HeaderSection(recipeName: recipe.title, animateHeader: animateHeader)
      VStack(spacing: .zero) {
        cookingInfoCards
        
        VStack(alignment: .leading) {
          Text("재료")
            .font(.title3)
            .fontWeight(.bold)
          IngredientsView(ingredients: modelData.userSelectedIngredient, animateCards: animateCards)
        }
        .padding(.top, 24)
        
        VStack(alignment: .leading) {
          Text("레시피")
            .font(.title3)
            .fontWeight(.bold)
          InstructionsView(instructions: recipe.directions, animateCards: animateCards)
        }
        .padding(.top, 24)
      }
      .padding(20)
    }
    .ignoresSafeArea()
    
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
}

// MARK: - Section Header
struct SectionHeader: View {
  let title: String
  let icon: String
  let animateCards: Bool
  
  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: icon)
        .font(DesignSystem.Typography.emojiSmall)
        .foregroundColor(.black)
      
      Text(title)
        .font(DesignSystem.Typography.title)
        .foregroundColor(.black)
      
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
    .opacity(animateCards ? 1 : 0)
  }
}

#Preview {
  RecipeDetailView(recipe: RecipeItem(title: "title", description: "de", category: .bakery, ingredients: ["a", "b"], directions: ["1", "2"], prepTime: "10분", cookTime: "10분", servings: "2인분"), modelData: RecipeGeneratorViewModel())
}
