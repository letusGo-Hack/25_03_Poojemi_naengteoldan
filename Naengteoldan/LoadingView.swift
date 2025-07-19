//
//  LoadingView.swift
//  Naengteoldan
//
//  Created by 송하민 on 7/19/25.
//

import SwiftUI

struct LoadingView: View {
  
  @Binding var isReceiptReady: Bool
  
  var body: some View {
    if isReceiptReady {
      LoadingAnimationView(isLoadingFinished: $isReceiptReady)
    }
  }
}

private struct LoadingAnimationView: View {
  @State private var rotation: Double = -20
  @Binding var isLoadingFinished: Bool
  
  var body: some View {
    ZStack {
      VStack(alignment: .center, spacing: 20) {
        Image(.fryingPan)
          .renderingMode(.template)
          .foregroundStyle(
            LinearGradient(
              gradient:
                Gradient(colors: [
                  Color(.purple),
                  Color(.blue)
                ])
              ,
              startPoint: .leading,
              endPoint: .trailing
            )
          )
          .rotationEffect(.degrees(rotation))
          .onAppear {
            withAnimation(.bouncy(duration: 0.18, extraBounce: 0.3).repeatForever(autoreverses: true)) {
              self.rotation += 75
            }
          }
      }
      .offset(x: isLoadingFinished ? 0 : -UIScreen.main.bounds.width - 100)
      .opacity(isLoadingFinished ? 1 : 0)
      
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  LoadingAnimationView(isLoadingFinished: .constant(true))
}
