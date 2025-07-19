//
//  Ingredient.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import Foundation

typealias IngredientRawValue = String

// MARK: - 식재료 데이터 모델

struct Ingredient: Identifiable, Hashable {
  let id = UUID()
  let name: String
  var isChecked: Bool = false
  var icon: IngredientIcon?

  var rawValue: IngredientRawValue {
    name
  }
}
