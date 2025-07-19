//
//  RecipeItem.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import SwiftUI
import FoundationModels

@Generable
struct RecipeItem: Identifiable {
  /// 레시피 고유 번호
  var id = UUID()
  
  @Guide(description: "이 레시피의 이름입니다. 예를 들어, '간단한 토마토 파스타'. 가능하다면 재료의 이름이 그대로 사용되지 않도록 하십시오. 예를 들어, '대패 삼겹살, 대파, 양파, 설탕'이 요리재료라면, 제육볶음이 더욱 어울립니다.")
  var title: String
  
  @Guide(description: "예: 계란말이, 또는 달걀말이는 달걀을 팬에 얇고 넓게 부친 뒤 만 음식이다. 반찬이나 술안주로 먹는다. 계란만 이용하기도 하지만 주로 야채 등을 다져 넣거나 김을 넣기도 한다.")
  var description: String
  
  @Guide(description: "이 레시피에 필요한 재료 목록입니다. 각 재료는 완전한 형태로 작성되어야 합니다.")
  var ingredients: [String]
  
  @Guide(
    description: "레시피를 준비하는 단계별 지침입니다. 각 단계는 짧고 명확한 문장으로 이루어져야 합니다. 주어진 재료만을 바탕으로 만들어야 하며, 주어지지 않은 재료로 만들어서는 안됩니다.",
    .minimumCount(5)
  )
  var directions: [String]
  
  @Guide(description: "레시피의 예상 준비 시간입니다. 예를 들어, '15분', '1시간 30분'")
  var prepTime: String? // 선택 사항
  
  @Guide(description: "레시피의 예상 요리 시간입니다. 예를 들어, '30분', '2시간'")
  var cookTime: String? // 선택 사항
  
  @Guide(description: "이 레시피로 만들 수 있는 음식의 양입니다. 예를 들어, '4인분', '2개'")
  var servings: String? // 선택 사항
}
