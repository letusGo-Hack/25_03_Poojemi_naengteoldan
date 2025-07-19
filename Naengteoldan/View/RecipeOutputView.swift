//
//  RecipeItemOutputView.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct RecipeItemOutputView: View {
    let recipe: RecipeItem
    @State private var isFavorite: Bool
    
    init(recipe: RecipeItem) {
        self.recipe = recipe
        self._isFavorite = State(initialValue: recipe.isFavorite)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                // 헤더 이미지 섹션
                ZStack(alignment: .bottomLeading) {
                    Image("FoodSample")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    // 그라데이션 오버레이
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // 제목
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(recipe.description)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(3)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    // 재료 섹션
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("재료")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("•")
                                        .foregroundColor(.accentColor)
                                        .font(.body)
                                    
                                    Text(ingredient)
                                        .font(.body)
                                        .lineLimit(nil)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    // 조리 방법 섹션
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("조리 방법")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(Array(recipe.directions.enumerated()), id: \.offset) { index, direction in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(alignment: .top, spacing: 12) {
                                        Text("\(index + 1)")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .frame(width: 28, height: 28)
                                            .background(Circle().fill(Color.accentColor))

                                        Text(direction)
                                            .font(.body)
                                            .lineLimit(nil)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 20)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .pink : .gray)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeItemOutputView(recipe: RecipeItem(
            id: 1,
            title: "계란말이",
            description: "계란말이, 또는 달걀말이는 달걀을 팬에 얇고 넓게 부친 뒤 만 음식이다. 반찬이나 술안주로 먹는다.",
            isFavorite: false,
            ingredients: [
                "달걀 4개",
                "당근 1/4개 (잘게 다진 것)",
                "양파 1/4개 (잘게 다진 것)",
                "소금 약간",
                "후추 약간",
                "식용유 약간"
            ],
            directions: [
                "볼에 달걀을 깨서 잘 풀고, 다진 야채(당근, 양파)를 넣습니다.",
                "소금과 후추로 간을 맞춘 후 잘 섞어줍니다.",
                "중약불로 달군 팬에 식용유를 두르고 달걀물을 얇게 붓습니다.",
                "가장자리가 익기 시작하면 한쪽부터 살살 말아줍니다.",
                "팬 끝까지 말았으면, 다시 식용유를 약간 두르고 남은 달걀물을 붓고 또 말아줍니다.",
                "모든 달걀물이 다 말릴 때까지 반복합니다.",
                "완성된 계란말이를 도마에 옮겨 먹기 좋은 크기로 썰어줍니다."
            ]
        ))
    }
}
