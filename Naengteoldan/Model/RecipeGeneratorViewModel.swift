//
//  RecipeGeneratorViewModel.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import SwiftUI
import Combine
import FoundationModels

class RecipeGeneratorViewModel: ObservableObject {
  @Published var ingredientsInput: String = ""
  @Published var generatedRecipe: Recipe?
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var modelAvailabilityStatus: String = "모델 가용성 확인 중..."
  
  var systemLanguageModel = SystemLanguageModel.default
  
  init() {
    checkModelAvailability()
  }
  
  private func checkModelAvailability() {
    switch systemLanguageModel.availability {
    case .available:
      modelAvailabilityStatus = "모델 사용 가능"
    case .unavailable(.deviceNotEligible):
      modelAvailabilityStatus = "오류: 기기가 Apple Intelligence를 지원하지 않습니다."
    case .unavailable(.appleIntelligenceNotEnabled):
      modelAvailabilityStatus = "오류: Apple Intelligence가 활성화되지 않았습니다. 시스템 설정에서 켜주세요."
    case .unavailable(.modelNotReady):
      modelAvailabilityStatus = "오류: 모델이 준비되지 않았습니다 (다운로드 중 또는 시스템 문제)."
    case .unavailable(let reason):
      modelAvailabilityStatus = "오류: 알 수 없는 이유로 모델을 사용할 수 없습니다. (\(reason))"
    }
  }
  
  
  func generateRecipe() {
    guard systemLanguageModel.availability == .available else {
      errorMessage = modelAvailabilityStatus
      return
    }
    
    isLoading = true
    errorMessage = nil
    generatedRecipe = nil
    
    Task { @MainActor in
      do {
        let session = LanguageModelSession()
        
        // 모델에 대한 지침(Instructions) 설정. 지침은 프롬프트보다 우선하여 모델의 행동을 유도합니다
        let instructions = Instructions("""
                    당신은 재료 목록을 바탕으로 실용적인 레시피를 만드는 전문 요리사입니다.
                    레시피 이름은 매력적이고 구체적이어야 합니다.
                    재료 목록은 항목별로 명확하게 구분되어야 합니다.
                    조리 지침은 명확하고 따라하기 쉬운 단계별 설명으로 이루어져야 합니다.
                    모든 문장은 한국어로 작성되어야 합니다.
                    """)
        
        let sessionWithInstructions = LanguageModelSession(instructions: instructions)
        
        let promptString = """
                다음 재료들을 사용하여 맛있는 요리의 레시피를 생성해 주세요: \(ingredientsInput).
                레시피는 제목, 재료 목록, 단계별 지침, 준비 시간, 요리 시간, 제공량을 포함해야 합니다.
                """
        let prompt = Prompt(promptString)
        
        // 가이드 생성을 사용하여 정의된 Recipe 구조체로 응답을 생성합니다.
        let response = try await sessionWithInstructions.respond(
          to: prompt,
          generating: Recipe.self,
          options: .init(temperature: 0)
        )
        
        // 생성된 Recipe 구조체에 접근합니다 [23].
        generatedRecipe = response.content
        
        isLoading = false
        
      } catch let error as LanguageModelSession.GenerationError {
        isLoading = false
        if case .guardrailViolation = error {
          errorMessage = "안전 가이드라인 위반: 민감하거나 부적절한 콘텐츠가 감지되었습니다. 다른 재료나 설명을 시도해 주세요."
        } else if case .exceededContextWindowSize = error {
          errorMessage = "컨텍스트 창 크기 초과: 재료 목록이나 프롬프트가 너무 깁니다. 더 짧게 입력해 주세요."
        } else {
          errorMessage = "모델 생성 오류: \(error.localizedDescription)"
        }
      } catch {
        isLoading = false
        errorMessage = "예기치 않은 오류가 발생했습니다: \(error.localizedDescription)"
      }
    }
  }
}
