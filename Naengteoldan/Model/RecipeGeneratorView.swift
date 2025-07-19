//
//  RecipeGeneratorView.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import SwiftUI
import Combine
import FoundationModels

struct RecipeGeneratorView: View {
  @StateObject private var viewModel = RecipeGeneratorViewModel()
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text(viewModel.modelAvailabilityStatus)
          .font(.caption)
          .foregroundColor(viewModel.modelAvailabilityStatus.contains("오류") ? .red : .primary)
          .padding(.horizontal)
        
        TextField("재료를 쉼표로 구분하여 입력하세요 (예: 양파, 감자, 소고기, 카레 가루)", text: $viewModel.ingredientsInput)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.horizontal)
          .autocorrectionDisabled()
        
        Button(action: viewModel.generateRecipe) {
          Text(viewModel.isLoading ? "레시피 생성 중..." : "레시피 생성")
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(viewModel.isLoading || viewModel.ingredientsInput.isEmpty ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(viewModel.isLoading || viewModel.ingredientsInput.isEmpty || viewModel.systemLanguageModel.availability != .available)
        .padding(.horizontal)
        
        if let recipe = viewModel.generatedRecipe {
          ScrollView {
            VStack(alignment: .leading, spacing: 10) {
              Text("**레시피 이름:** \(recipe.name)")
                .font(.title2)
                .padding(.bottom, 5)
              
              if let prepTime = recipe.prepTime {
                Text("**준비 시간:** \(prepTime)")
                  .font(.subheadline)
              }
              if let cookTime = recipe.cookTime {
                Text("**요리 시간:** \(cookTime)")
                  .font(.subheadline)
              }
              if let servings = recipe.servings {
                Text("**제공량:** \(servings)")
                  .font(.subheadline)
              }
              
              Divider()
              
              Text("**재료:**")
                .font(.headline)
              ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text("- \(ingredient)")
              }
              
              Divider()
              
              Text("**조리 지침:**")
                .font(.headline)
              ForEach(recipe.instructions.indices, id: \.self) { index in
                Text("\(index + 1). \(recipe.instructions[index])")
              }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
          }
        } else if let error = viewModel.errorMessage {
          Text("오류: \(error)")
            .foregroundColor(.red)
            .padding()
        }
        
        Spacer()
      }
      .navigationTitle("AI 레시피 생성기")
    }
  }
}
