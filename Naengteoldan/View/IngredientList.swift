//
//  IngredientList.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

import SwiftUI

struct IngredientList: View {
    var body: some View {
        List {
            Text("계란")
            Text("식빵")
        }
        .safeAreaBar(edge: .bottom) {
            Button(role: .confirm) {

            } label: {
                Label("AI 레시피 추천", systemImage: "apple.intelligence")
                    .foregroundStyle(
                        MeshGradient(width: 2, height: 2, points: [
                            [0, 0], [1, 0],
                            [0, 1], [1, 1]
                        ], colors: [
                            .pink, .indigo,
                            .indigo, .blue
                        ])
                    )
                    .padding(8)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.glass)
            .padding(.bottom)
        }
        .navigationTitle("냉장고 재료")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("추가", systemImage: "plus") {

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
