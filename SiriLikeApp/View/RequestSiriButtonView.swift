//
//  RequestSiriButtonView.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 22/01/25.
//

import SwiftUI

struct RequestSiriButtonView: View {
    
    @Binding var siriStatus: SiriStatus
    
    private let gradientColors = [
        Color.white.opacity(0.8),
        Color.white.opacity(0.1),
        Color.white.opacity(0.1),
        Color.white.opacity(0.4),
        Color.white.opacity(0.5)
    ]
    
    @State var buttonHeight: CGFloat = 60
    var buttonWidth: CGFloat {
        switch self.siriStatus {
        case .thinking:
            return buttonHeight
        case .disabled:
            return 250
        }
    }
    @State private var rotation: CGFloat = 0.0
    
    @State var scaleButton: CGFloat = 1.0
    
    var buttonAnimationDuration: CGFloat = 4.0
    var autoreverseButtonAnimation: Bool = false
    
    var tapped: () -> Void
    
    var body: some View {
        ZStack {
            Group {
            
                Capsule()
                    .fill(Material.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .overlay {
                        Capsule()
                            .stroke(LinearGradient(colors: self.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .blur(radius: 5)
                    .frame(width: 40, height: (self.buttonWidth / 2) + 20)
                    .rotationEffect(.degrees(self.rotation), anchor: .top)
                    .offset(y: ((self.buttonWidth / 2) + 20) / 2)
                                        .mask {
                                            Capsule()
                                                .stroke(lineWidth: 1)
                                                .frame(width: buttonWidth - 2, height: buttonHeight - 2)
                                        }
                
                
                
                
                ZStack {
                    if self.siriStatus == .thinking {
                        Image(systemName: "xmark")
                            .id("0")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .transition(
                                .customAsymmetricMove(insertionOffset: 20, removalOffset: -20)
                            )
                    }else if self.siriStatus == .disabled {
                        Text("Ask Siri")
                            .id("1")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .transition(
                                .customAsymmetricMove(insertionOffset: 20, removalOffset: -20)
                            )
                    }
                }
                
                
                
            }
            .scaleEffect(self.scaleButton)
            .animation(.snappy(duration: 0.6, extraBounce: 0.1), value: self.siriStatus)
            
                
        }
        .frame(height: self.buttonHeight)
        .onAppear {
            withAnimation(.linear(duration: self.buttonAnimationDuration).repeatForever(autoreverses: self.autoreverseButtonAnimation)) {
                self.rotation = 360
            }
        }
        .onTapGesture {
            let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
            hapticFeedback.impactOccurred()
            
            withAnimation(.snappy(duration: 0.1, extraBounce: 0.1)) {
                self.scaleButton = 0.9
            } completion: {
                withAnimation(.snappy(duration: 0.1, extraBounce: 0.1)){
                    self.scaleButton = 1.0
                }
            }
            
            self.tapped()
        }
    }
}

#Preview {
    RequestSiriButtonView(siriStatus: .constant(.disabled)) {
        
    }
}
