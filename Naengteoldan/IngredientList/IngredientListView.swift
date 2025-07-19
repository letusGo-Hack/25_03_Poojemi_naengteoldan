//
//  IngredientListView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//
import SwiftUI

// MARK: - 메인 뷰
struct IngredientChecklistView: View {
  
  // MARK: - Binding Properties (외부에서 바인딩 가능)
  @Binding var selectedIngredients: [IngredientRawValue]           // 체크된 식재료들
  @Binding var sliderValue: Double                     // 슬라이더 값 (0~2)
  
  // MARK: - Closure Properties
  let onGenerateButtonTapped: () -> Void               // 생성 버튼 액션
  
  // MARK: - State Properties
  @State private var ingredientText: String = ""        // 입력 필드 텍스트
  @State private var ingredients: [Ingredient] = []     // 식재료 리스트
  @State private var showGenerateModal: Bool = false    // 생성 모달 표시 상태
  
  // MARK: - Initializer
  init(
    selectedIngredients: Binding<[IngredientRawValue]>,
    sliderValue: Binding<Double>,
    onGenerateButtonTapped: @escaping () -> Void
  ) {
    self._selectedIngredients = selectedIngredients
    self._sliderValue = sliderValue
    self.onGenerateButtonTapped = onGenerateButtonTapped
  }
  
  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        
        // MARK: - 입력 섹션
        inputSection
        
        // MARK: - 리스트 섹션
        listSection
        
        // MARK: - 체크된 항목 결과 섹션
        checkedIngredientsSection
        
        Spacer()
      }
      .padding()
      .navigationTitle("식재료 체크리스트")
      .navigationBarTitleDisplayMode(.large)
    }
  }
  
  // MARK: - 입력 섹션 뷰
  private var inputSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("식재료 추가")
        .font(.headline)
        .foregroundColor(.primary)
      
      HStack {
        // 텍스트 입력 필드
        TextField("식재료를 입력하세요", text: $ingredientText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .onSubmit {
            addIngredient()
          }
        
        // 추가 버튼
        Button(action: addIngredient) {
          Image(systemName: "plus.circle.fill")
            .font(.title2)
            .foregroundColor(.blue)
        }
        .disabled(ingredientText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
      }
    }
  }
  
  // MARK: - 리스트 섹션 뷰
  private var listSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("식재료 목록")
          .font(.headline)
          .foregroundColor(.primary)
        
        Spacer()
        
        // 전체 아이템 수와 체크된 아이템 수 표시
        Text("\(checkedCount)/\(ingredients.count)")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      Spacer()
      
      if ingredients.isEmpty {
        // 빈 상태 뷰
        emptyStateView
      } else {
        // 식재료 리스트
        ingredientList
      }
    }.padding()
  }
  
  // MARK: - 빈 상태 뷰
  private var emptyStateView: some View {
    VStack(spacing: 16) {
      Image(systemName: "list.bullet.clipboard")
        .font(.system(size: 48))
        .foregroundColor(.gray.opacity(0.6))
      
      Text("아직 추가된 식재료가 없습니다")
        .font(.body)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 40)
  }
  
  // MARK: - 체크된 식재료 섹션 뷰
  private var checkedIngredientsSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Text("체크된 식재료")
          .font(.headline)
          .foregroundColor(.primary)
        
        Spacer()
        
        // 개수 표시
        Text("\(checkedIngredients.count)개")
          .font(.subheadline)
          .foregroundColor(.secondary)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
      }
      
      if checkedIngredients.isEmpty {
        // 빈 상태 뷰 (체크된 식재료가 없을 때)
        VStack(spacing: 12) {
          Image(systemName: "checkmark.circle")
            .font(.system(size: 32))
            .foregroundColor(.gray.opacity(0.6))
          
          Text("체크된 식재료가 없습니다")
            .font(.body)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
          
          Text("위에서 식재료를 선택해주세요")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
      } else {
        // 체크된 식재료들을 텍스트로 표시
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 8) {
            ForEach(checkedIngredients) { ingredient in
              HStack {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.green)
                  .font(.system(size: 16))
                
                Text(ingredient.name)
                  .font(.body)
                  .foregroundColor(.primary)
                
                Spacer()
              }
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.green.opacity(0.05))
              .cornerRadius(8)
            }
          }
        }
        .frame(maxHeight: 150)
        .padding(.horizontal, 4)
      }
      
      // MARK: - 생성 버튼
      generateButton
    }
    .sheet(isPresented: $showGenerateModal) {
      GenerateModalView(
        selectedIngredients: checkedIngredientRawValues,
        sliderValue: $sliderValue,
        onGenerate: {
          showGenerateModal = false
          updateSelectedIngredients()
          onGenerateButtonTapped()
        }
      )
    }
  }
  
  // MARK: - 생성 버튼
  private var generateButton: some View {
    Button(action: {
      showGenerateModal = true
    }) {
      HStack {
        Image(systemName: "wand.and.stars")
          .font(.title2)
        
        Text("생성하기")
          .font(.headline)
          .fontWeight(.semibold)
      }
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .frame(height: 56)
      .background(
        LinearGradient(
          colors: checkedIngredients.isEmpty ? [.gray] : [.blue, .purple],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .cornerRadius(16)
      .shadow(color: checkedIngredients.isEmpty ? .clear : .blue.opacity(0.3), radius: 8, x: 0, y: 4)
    }
    .disabled(checkedIngredients.isEmpty)
    .animation(.easeInOut(duration: 0.2), value: checkedIngredients.isEmpty)
  }
  private var ingredientList: some View {
    List {
      ForEach(ingredients.indices, id: \.self) { index in
        IngredientRowView(
          ingredient: ingredients[index],
          onToggle: {
            toggleIngredient(at: index)
          },
          onDelete: {
            deleteIngredient(at: index)
          }
        )
      }
      .onDelete(perform: deleteIngredients)
    }
    .listStyle(PlainListStyle())
    .frame(maxHeight: 300) // 리스트 최대 높이 제한
  }
  
  // MARK: - 계산된 속성
  private var checkedCount: Int {
    ingredients.filter { $0.isChecked }.count
  }
  
  /// 체크된 식재료들을 반환하는 계산된 속성
  var checkedIngredients: [Ingredient] {
    ingredients.filter { $0.isChecked }
  }
  
  /// 체크된 식재료 RawValue(생성용 값)들만 String 배열로 반환
  var checkedIngredientRawValues: [IngredientRawValue] {
    checkedIngredients.map { $0.rawValue }
  }
  
  // MARK: - 액션 메서드들
  
  /// 새로운 식재료를 리스트에 추가
  private func addIngredient() {
    let trimmedText = ingredientText.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // 빈 텍스트나 중복 체크
    guard !trimmedText.isEmpty,
          !ingredients.contains(where: { $0.name.lowercased() == trimmedText.lowercased() }) else {
      return
    }
    
    Task {
      //TODO: - 만약 생성 시 식재료 검증을 한다면 이 영역에서 처리
      let newIngredient = Ingredient(name: trimmedText)
      ingredients.append(newIngredient)
      ingredientText = "" // 입력 필드 초기화
    }
  }
  
  /// 특정 인덱스의 식재료 체크 상태 토글
  private func toggleIngredient(at index: Int) {
    guard ingredients.indices.contains(index) else { return }
    ingredients[index].isChecked.toggle()
    updateSelectedIngredients() // 체크 상태 변경시 외부 바인딩 업데이트
  }
  
  /// 특정 인덱스의 식재료 삭제
  private func deleteIngredient(at index: Int) {
    guard ingredients.indices.contains(index) else { return }
    ingredients.remove(at: index)
    updateSelectedIngredients() // 삭제시에도 외부 바인딩 업데이트
  }
  
  /// 여러 식재료 삭제 (swipe-to-delete 지원)
  private func deleteIngredients(offsets: IndexSet) {
    ingredients.remove(atOffsets: offsets)
    updateSelectedIngredients() // 삭제시에도 외부 바인딩 업데이트
  }
  
  /// 외부 바인딩된 selectedIngredients 업데이트
  private func updateSelectedIngredients() {
    selectedIngredients = checkedIngredientRawValues
  }

}


// MARK: 미사용 코드
extension IngredientChecklistView {
  /// 체크된 식재료 데이터를 구조화된 형태로 반환
  func getCheckedIngredientsData() -> (count: Int, names: [IngredientRawValue], ingredients: [Ingredient]) {
    return (
      count: checkedIngredients.count,
      names: checkedIngredientRawValues,
      ingredients: checkedIngredients
    )
  }
  
  /// 체크된 식재료 결과를 반환하고 출력 (디버깅/테스트용)
  private func getCheckedIngredientsResult() {
    let result = getCheckedIngredientsData()
    print("=== 체크된 식재료 결과 ===")
    print("총 개수: \(result.count)")
    print("식재료 목록: \(result.names)")
    print("상세 정보: \(result.ingredients)")
  }
  
}


// MARK: - 프리뷰
#Preview {
  ParentView()
}
