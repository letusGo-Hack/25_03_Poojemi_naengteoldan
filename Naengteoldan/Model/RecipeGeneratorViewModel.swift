//
//  RecipeGeneratorViewModel.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import SwiftUI
import Combine
import FoundationModels

@Observable
class RecipeGeneratorViewModel {
  
  // MARK: - Public Properties
  var generatedRecipe: RecipeItem?
  var isLoading: Bool = false
  var errorMessage: String?
  var modelAvailabilityStatus: String = "모델 가용성 확인 중..."
  
  var userSelectedIngredient: [Ingredient] = []
  
  // MARK: - Private Properties
  
  private let systemLanguageModel = SystemLanguageModel.default
  private var session: LanguageModelSession?
  
  // MARK: - Computed Properties
  
  var isModelAvailable: Bool {
    systemLanguageModel.availability == .available
  }
  
  // MARK: - Initialization
  
  init() {
    checkModelAvailability()
    setupSession()
  }
  
  // MARK: - Public Methods
  
  @MainActor
  func performRecipeGeneration(gradient: [String]) async {
    isLoading = true
    errorMessage = nil
    generatedRecipe = nil
    
    do {
      let cleanedIngredients = gradient.joined(separator: ",").trimmingCharacters(in: .whitespacesAndNewlines)
      let prompt = createPrompt(for: cleanedIngredients)
      
      guard let session = session else {
        throw RecipeGenerationError.sessionNotAvailable
      }
      
      let response = try await session.respond(
        to: prompt,
        generating: RecipeItem.self,
        options: GenerationOptions(
          sampling: .greedy,
          temperature: 0.4
        )
      )
      
      generatedRecipe = response.content
      
      print("result ~> \(generatedRecipe)")
    } catch {
      print(error)
      self.errorMessage = error.localizedDescription
//      clearResults()
    }
    
    isLoading = false
  }
  
  @MainActor
  func clearResults() {
    generatedRecipe = nil
    errorMessage = nil
  }
  
  // MARK: - Private Methods
  private func checkModelAvailability() {
    modelAvailabilityStatus = switch systemLanguageModel.availability {
    case .available:
      "모델 사용 가능"
    case .unavailable(.deviceNotEligible):
      "오류: 기기가 Apple Intelligence를 지원하지 않습니다."
    case .unavailable(.appleIntelligenceNotEnabled):
      "오류: Apple Intelligence가 활성화되지 않았습니다. 시스템 설정에서 켜주세요."
    case .unavailable(.modelNotReady):
      "오류: 모델이 준비되지 않았습니다. 잠시 후 다시 시도해주세요."
    case .unavailable(let reason):
      "오류: 모델을 사용할 수 없습니다. (\(reason))"
    }
  }
  
  private func setupSession() {
    guard isModelAvailable else { return }
    
    let instructions = Instructions("""
            당신은 재료 목록을 바탕으로 실용적이고 맛있는 레시피를 만드는 전문 요리사입니다.
            
            다음 규칙을 따라 레시피를 생성해주세요:
            1. 레시피 이름은 매력적이고 추상적이어야 합니다.
            2. 재료 목록은 정확한 양과 함께 명시해주세요.
            3. 조리 지침은 명확하고 따라하기 쉬운 단계별 설명으로 작성해주세요.
            4. 반드시 주어진 재료로만 만들어야 합니다.
            5. 모든 내용은 한국어로 작성해주세요.
            """)
    
    session = LanguageModelSession(instructions: instructions)
  }
  
  private func createPrompt(for ingredients: String) -> Prompt {
    Prompt("""
            다음 재료들을 주재료로 사용하여 맛있고 실용적인 요리의 레시피를 생성해 주세요: \(ingredients)
            
            요구사항:
            - 제시된 재료만을 가지고 만들어야 합니다.
            - 일반 가정에서 만들 수 있는 현실적인 레시피여야 합니다.
            - 모든 단계는 구체적이고 명확해야 합니다.
            """)
  }
  
  @MainActor
  private func handleError(_ error: Error) {
    if let generationError = error as? LanguageModelSession.GenerationError {
      errorMessage = switch generationError {
      case .guardrailViolation:
        "안전 가이드라인 위반: 적절하지 않은 내용이 감지되었습니다. 다른 재료로 시도해 주세요."
      case .exceededContextWindowSize:
        "입력이 너무 깁니다. 재료 목록을 더 간단하게 입력해 주세요."
      case .unsupportedLanguageOrLocale:
        "지원되지 않는 언어입니다. 한국어로 재료를 입력해 주세요."
      default:
        "레시피 생성 중 오류가 발생했습니다: \(generationError.localizedDescription)"
      }
    } else if let customError = error as? RecipeGenerationError {
      errorMessage = customError.localizedDescription
    } else {
      errorMessage = "예기치 않은 오류가 발생했습니다. 다시 시도해 주세요."
    }
  }
}

// MARK: - Custom Errors

enum RecipeGenerationError: LocalizedError {
  case sessionNotAvailable
  case invalidInput
  
  var errorDescription: String? {
    switch self {
    case .sessionNotAvailable:
      return "세션을 사용할 수 없습니다. 앱을 다시 시작해 주세요."
    case .invalidInput:
      return "유효하지 않은 입력입니다."
    }
  }
}

// MARK: - Extensions
extension RecipeGeneratorViewModel {
  
  /// 모델 상태를 다시 확인하고 세션을 재설정합니다
  @MainActor
  func refreshModelStatus() {
    checkModelAvailability()
    setupSession()
  }
  
  /// 입력 검증을 수행합니다
  func validateInput(_ input: String) -> Bool {
    let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
    return !trimmed.isEmpty && trimmed.count >= 2
  }
  
  /// 재료 입력을 정리합니다
  func sanitizeIngredients(_ input: String) -> String {
    return input
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
  }
}
