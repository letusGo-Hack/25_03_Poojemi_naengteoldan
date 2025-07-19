//
//  ParentView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import SwiftUI

// MARK: - 사용 예시: 외부에서 IngredientChecklistView 사용하는 방법

struct ParentView: View {
  @State private var selectedIngredients: [IngredientRawValue] = []
  @State private var sliderValue: Double = 1.0
  
  var body: some View {
    //    VStack {
    IngredientChecklistView(
      selectedIngredients: $selectedIngredients,
      sliderValue: $sliderValue,
      onGenerateButtonTapped: {
        // 생성 버튼 클릭시 실행될 로직
        handleGenerate()
      }
    )
  }
  
  private func handleGenerate() {
    print("=== 생성 요청 ===")
    print("선택된 식재료: \(selectedIngredients)")
    print("강도: \(sliderValue)")
    print("퍼센티지: \((sliderValue / 2.0) * 100)%")
    
    // 여기에 실제 생성 로직 구현
    // 예: API 호출, 데이터 처리 등
  }
}


