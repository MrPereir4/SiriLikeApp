//
//  SparklesEffectView.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 23/01/25.
//

import SwiftUI
import GameplayKit

struct ParticleView: View {
    @State var position: CGPoint = CGPoint(x: Double.random(in: -200...200), y: -10)
    
    /// Propriedades visuais da partícula
    let horizontalWidth: CGFloat
    let size: CGSize
    let color: Color
    @State var blur: CGFloat = 1
    
    @State var opacity: Double = 1.0
    
    @Binding var siriStatus: SiriStatus
    
    init(horizontalWidth: CGFloat, size: CGSize, siriStatus: Binding<SiriStatus>) {
        self.horizontalWidth = horizontalWidth
        self.size = size
        self.color = .white
        self._siriStatus = siriStatus
        
        self.position.x = horizontalWidth / 2
    }
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size.width, height: size.height)
            .blur(radius: blur)
            .offset(x: position.x, y: position.y)
            .opacity(self.opacity)
            .onChange(of: self.siriStatus) {
                switch self.siriStatus {
                case .thinking:
                    self.animateSparkle()
                case .disabled:
                    self.opacity = 1.0
                    self.blur = 1.0
                    self.position = CGPoint(x: Double.random(in: -200...200), y: -10)
                }
                
            }
    }
    
    
    private func animateSparkle() {
        let pointDestination = CGPoint(x: CGFloat.random(in: -self.horizontalWidth...self.horizontalWidth),
                                       y: Double.random(in: 600...700))
        
        withAnimation(.easeOut(duration: Double.random(in: 1..<6))) {
            self.position = pointDestination
            self.blur = 1
        }
        
        withAnimation(.easeOut(duration: 3)) {
            self.opacity = 0.0
        }
        
        
    }
    
    private func resetSparkles() {
        
    }
}

// MARK: - View principal que controla tudo
struct SparklesEffectView: View {
    
    /// Quantidade total de partículas
    var quantityOfParticles: Int = 15
    
    @Binding var siriStatus: SiriStatus
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack {
                ZStack(alignment: .topLeading) {
                    ForEach(0..<self.quantityOfParticles, id: \.self) { index in
                        let size = Double.random(in: 3..<4)
                        ParticleView(horizontalWidth: proxy.size.width, size: CGSize(width: size, height: size), siriStatus: self.$siriStatus)
                    }
                    
                }
                Spacer()
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            
        }
    }
}

// MARK: - Gerador Determinístico de Números Aleatórios
struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var generator: GKMersenneTwisterRandomSource

    init(seed: Float) {
        self.generator = GKMersenneTwisterRandomSource(seed: UInt64(seed * 1_000_000))
    }

    mutating func next() -> UInt64 {
        return UInt64(generator.nextInt(upperBound: Int(UInt32.max)))
    }
}

// MARK: - Preview SwiftUI
#Preview {
    SparklesEffectView(siriStatus: .constant(.disabled))
}
