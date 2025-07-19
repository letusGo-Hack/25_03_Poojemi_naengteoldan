//
//  IngredientRowView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import SwiftUI

// MARK: - 식재료 행 뷰
struct IngredientRowView: View {
  let ingredient: Ingredient
  let onToggle: () -> Void
  let onDelete: () -> Void
  
  var body: some View {
    HStack(spacing: 12) {
      // 체크박스
      Button(action: onToggle) {
        Image(systemName: ingredient.isChecked ? "checkmark.circle.fill" : "circle")
          .font(.title2)
          .foregroundColor(ingredient.isChecked ? .green : .gray)
      }
      .buttonStyle(PlainButtonStyle())
      
      // 식재료 이름
      Text(ingredient.name)
        .font(.body)
        .foregroundColor(ingredient.isChecked ? .secondary : .primary)
        .strikethrough(ingredient.isChecked)
      
      Spacer()
      
      // 삭제 버튼
      Button(action: onDelete) {
        Image(systemName: "trash")
          .font(.caption)
          .foregroundColor(.red)
      }
      .buttonStyle(PlainButtonStyle())
    }
    .padding(.vertical, 4)
    .contentShape(Rectangle()) // 전체 영역 탭 가능하게 만들기
    .onTapGesture {
      onToggle()
    }
  }
}
