//
//  Recipe.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import FoundationModels
import SwiftUI

@Generable
struct RecipeItem: Identifiable {
  /// 레시피 고유 번호
  var id = UUID()
  
  @Guide(description: "이 레시피의 이름입니다. 예를 들어, '간단한 토마토 파스타'. 가능하다면 재료의 이름이 그대로 사용되지 않도록 하십시오. 예를 들어, '대패 삼겹살, 대파, 양파, 설탕'이 요리재료라면, '제육볶음'이 더욱 어울립니다.")
  var title: String
  
  @Guide(description: "예: 계란말이, 또는 달걀말이는 달걀을 팬에 얇고 넓게 부친 뒤 만 음식이다. 반찬이나 술안주로 먹는다. 계란만 이용하기도 하지만 주로 야채 등을 다져 넣거나 김을 넣기도 한다.")
  var description: String
  
  @Guide(description: "이 레시피의 음식 카테고리입니다. 주어진 재료와 요리 방법을 고려하여 가장 적절한 카테고리를 선택하세요. 예: 돼지고기 볶음 요리는 stirFriedMeat, 김치찌개는 stew, 잡채는 stirFriedVegetable")
  var category: FoodSubCategory
  
  @Guide(description: "이 레시피에 필요한 재료 목록입니다.")
  var ingredients: [String]
  
  @Guide(
    description: "레시피를 준비하는 단계별 지침입니다. 각 단계는 짧고 명확한 문장으로 이루어져야 합니다. 반드시 주어진 재료만을 바탕으로 만들어야 하며, 주어지지 않은 재료로 만들어서는 안됩니다.",
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

@Generable
enum FoodSubCategory: String, CaseIterable {
  // 식사류
  case rice = "rice"                    // 밥류
  case noodle = "noodle"               // 면류
  case bread = "bread"                 // 빵류
  case riceCake = "riceCake"           // 떡류
  
  // 국물류
  case soup = "soup"                   // 국류
  case stew = "stew"                   // 찌개류
  case hotpot = "hotpot"               // 전골/탕류
  
  // 고기 요리
  case grilledMeat = "grilledMeat"     // 구이류
  case stirFriedMeat = "stirFriedMeat" // 볶음류
  case braisedMeat = "braisedMeat"     // 찜류
  
  // 해산물 요리
  case fish = "fish"                   // 생선류
  case seafoodStirFry = "seafoodStirFry" // 해산물 볶음/찜류
  
  // 채소 요리
  case seasonedVegetable = "seasonedVegetable" // 나물류
  case salad = "salad"                 // 샐러드류
  case stirFriedVegetable = "stirFriedVegetable" // 채소볶음류
  
  // 반찬류
  case eggTofu = "eggTofu"            // 계란/두부류
  case pickledSalted = "pickledSalted" // 젓갈/절임류
  case driedSideDish = "driedSideDish" // 마른반찬류
  
  // 간식/분식류
  case flourSnack = "flourSnack"       // 밀가루 간식류
  case instantFood = "instantFood"     // 즉석 조리류
  case streetFood = "streetFood"       // 길거리 음식류
  
  // 디저트
  case bakery = "bakery"               // 베이커리류
  case iceCream = "iceCream"           // 아이스크림/빙과류
  case jellyPudding = "jellyPudding"   // 젤리/푸딩류
}
