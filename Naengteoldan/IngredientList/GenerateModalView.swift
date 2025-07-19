//
//  GenerateModalView.swift
//  Naengteoldan
//
//  Created by 0-jerry on 7/19/25.
//

import SwiftUI

// MARK: - 생성 모달 뷰
struct GenerateModalView: View {
  let selectedIngredients: [IngredientRawValue]
  @Binding var sliderValue: Double
  let onGenerate: () -> Void
  
  @Environment(\.dismiss) private var dismiss
  @State private var localSliderValue: Double = 1.0  // 로컬 슬라이더 값
  
  /// 슬라이더 값을 퍼센티지로 변환 (0~2 -> 0~100%)
  private var gaugePercentage: Double {
    (localSliderValue / 2.0) * 100.0
  }
  
  var body: some View {
    NavigationView {
      VStack(spacing: 24) {
        // MARK: - 선택된 식재료 섹션
        selectedIngredientsSection
        
        // MARK: - 강도 설정 섹션
        intensitySection
        
        Spacer()
        
        // MARK: - 최종 생성 버튼
        finalGenerateButton
      }
      .padding()
      .navigationTitle("생성 설정")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("취소") {
            dismiss()
          }
        }
      }
      .onAppear {
        localSliderValue = sliderValue  // 초기값 설정
      }
    }
  }
  
  // MARK: - 선택된 식재료 섹션
  private var selectedIngredientsSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("선택된 식재료")
          .font(.headline)
          .foregroundColor(.primary)
        
        Spacer()
        
        Text("\(selectedIngredients.count)개")
          .font(.subheadline)
          .foregroundColor(.secondary)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(selectedIngredients, id: \.self) { ingredient in
            Text(ingredient)
              .font(.body)
              .padding(.horizontal, 12)
              .padding(.vertical, 6)
              .background(Color.green.opacity(0.1))
              .foregroundColor(.green)
              .cornerRadius(20)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.green.opacity(0.3), lineWidth: 1)
              )
          }
        }
        .padding(.horizontal, 4)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(12)
  }
  
  // MARK: - 강도 설정 섹션
  private var intensitySection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("강도 설정")
        .font(.headline)
        .foregroundColor(.primary)
      
      HStack(spacing: 20) {
        // 슬라이더 섹션
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text("약함")
              .font(.caption)
              .foregroundColor(.secondary)
            
            Spacer()
            
            Text("강함")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          
          Slider(value: $sliderValue, in: 0...2, step: 0.1)
            .accentColor(.blue)
          
          HStack {
            Text("값: \(sliderValue, specifier: "%.1f")")
              .font(.caption)
              .foregroundColor(.secondary)
            
            Spacer()
            
            Text(intensityDescription)
              .font(.caption)
              .fontWeight(.medium)
              .foregroundColor(intensityColor)
          }
        }
        
        // 게이지 섹션
        VStack(spacing: 8) {
          Text("\(gaugePercentage, specifier: "%.0f")%")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.blue)
          
          // 원형 게이지
          ZStack {
            Circle()
              .stroke(Color.gray.opacity(0.2), lineWidth: 12)
              .frame(width: 80, height: 80)
            
            Circle()
              .trim(from: 0, to: CGFloat(sliderValue / 2.0))
              .stroke(
                LinearGradient(
                  colors: [.green, .yellow, .orange, .red],
                  startPoint: .leading,
                  endPoint: .trailing
                ),
                style: StrokeStyle(lineWidth: 12, lineCap: .round)
              )
              .frame(width: 80, height: 80)
              .rotationEffect(.degrees(-90))
              .animation(.easeInOut(duration: 0.3), value: sliderValue)
          }
        }
      }
    }
    .padding()
    .background(Color.blue.opacity(0.05))
    .cornerRadius(12)
  }
  
  // MARK: - 최종 생성 버튼
  private var finalGenerateButton: some View {
    Button(action: onGenerate) {
      HStack {
        Image(systemName: "sparkles")
          .font(.title2)
        
        Text("생성 시작")
          .font(.headline)
          .fontWeight(.semibold)
      }
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .frame(height: 56)
      .background(
        LinearGradient(
          colors: [.purple, .blue],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .cornerRadius(16)
      .shadow(color: .purple.opacity(0.3), radius: 8, x: 0, y: 4)
    }
  }
  
  // MARK: - 계산된 속성들
  private var intensityDescription: String {
    switch sliderValue {
    case 0...0.7:
      return "약함"
    case 0.7...1.3:
      return "보통"
    case 1.3...2.0:
      return "강함"
    default:
      return "보통"
    }
  }
  
  private var intensityColor: Color {
    switch sliderValue {
    case 0...0.7:
      return .green
    case 0.7...1.3:
      return .orange
    case 1.3...2.0:
      return .red
    default:
      return .orange
    }
  }
}
