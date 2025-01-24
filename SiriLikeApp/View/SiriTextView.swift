//
//  SiriTextView.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 22/01/25.
//

import SwiftUI

struct SiriTextView: View {
    @Binding var siriStatus: SiriStatus
    
    private let randomPhase = Double.random(in: 0...(2 * .pi)) // Fase fixa
    private let range: CGFloat = 2.0 // Amplitude máxima
    
    @State private var time: Double = 0.0
    var body: some View {
        
        VStack {
            Spacer()
            if self.siriStatus == .thinking {
                Text("How can i help\nyou today?")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .white.opacity(0.3), radius: 5)
                    .multilineTextAlignment(.center)
                    .offset(x: sineFluctuation(base: 0, range: range, time: time, phase: randomPhase, randomSeed: 1.2), y: sineFluctuation(base: 0, range: range, time: time, phase: randomPhase, randomSeed: 1.8))
                    .transition(
                        .asymmetric(insertion: .modifier(active: OffsetAndScaleEffect(offset: -20, scale: 0.9, opacity: 0.0),
                                                         identity: OffsetAndScaleEffect(offset: 0, scale: 1.0, opacity: 1.0)),
                                    removal: .modifier(active: OffsetAndScaleEffect(offset: 20, scale: 0.9, opacity: 0.0),
                                                       identity: OffsetAndScaleEffect(offset: 0, scale: 1.0, opacity: 1.0)))
                    )
                    .onTapGesture {
                        self.siriStatus = .thinking
                    }
            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.6), value: self.siriStatus)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
                self.time += 0.016
            }
        }
        
    }

    func sineFluctuation(base: CGFloat, range: CGFloat, time: Double, phase: Double, randomSeed: Double) -> CGFloat {
        let frequency: Double = 1.6 // Frequência fixa para suavidade
        let sineValue = sin(((time * randomSeed) * frequency) + phase) // Movimento suave
        return base + (range * CGFloat(sineValue))
    }


    
}

#Preview {
    @Previewable @State var status: SiriStatus = .disabled
    VStack {
        Button {
            switch status {
            case .thinking:
                status = .disabled
            case .disabled:
                status = .thinking
            }
        } label: {
            Text("Change")
        }

        SiriTextView(siriStatus: $status)
    }
    .frame(maxWidth: .infinity)
    .background(.black)
    
    
}
