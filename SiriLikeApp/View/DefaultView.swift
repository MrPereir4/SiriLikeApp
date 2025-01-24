//
//  DefaultView.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 21/01/25.
//

import SwiftUI
import AVFoundation

enum SiriStatus {
    case thinking, disabled
}

struct DefaultView: View {
    
    @State var siriStatus: SiriStatus = .disabled
    
    @State var trigger: Int = 0
    
    @State private var dynamicIslandCenter: CGPoint? = nil
    
    private var safeAreaTopSpacing: CGFloat = 11
    private var dynamicIslandHeight: CGFloat = 37
    private var dynamicIslandWidth: CGFloat = 125
    
    @State private var maskTimer: Float = 0.0
    @State var gradientSpeed: Float = 0.03
    
    var siriAudioCall: AVAudioPlayer? = AudioHandler().siriCallAudio()
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                
                ZStack {
                    Image("mainBackground")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(1.3)
                    
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .scaleEffect(1.3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .opacity(self.siriStatus == .disabled ? 0.0 : 1.0)
                        .animation(.linear(duration: 0.55), value: self.siriStatus)
                    
                    SparklesEffectView(siriStatus: self.$siriStatus)
                    
                    SiriTextView(siriStatus: self.$siriStatus)
                    
                    
                    VStack {
                        Spacer()
                        RequestSiriButtonView(siriStatus: self.$siriStatus) {
                            switch siriStatus {
                            case .thinking:
                                self.siriStatus = .disabled
                            case .disabled:
                                self.trigger += 1
                                self.siriStatus = .thinking
                                if let siriAudioCall {
                                    siriAudioCall.stop()
                                    siriAudioCall.currentTime = 0
                                    siriAudioCall.play()
                                }
                            }
                            
                            
                        }
                        
                            
                    }
                }
                .modifier(RippleEffect(at: CGPoint(x: self.dynamicIslandCenter?.x ?? 0.0, y: 0), trigger: trigger))
                
                ZStack {
                    VStack {
                        SiriDynamicIsland(siriStatus: self.$siriStatus)
                            .padding(.top, 14)
                        Spacer()
                    }
                }

            }
            .onAppear {
                self.dynamicIslandCenter = getDynamicIslandCenter(in: proxy.size)
            }
        }
        .ignoresSafeArea(edges: [.top])
        
    }
}

#Preview {
    DefaultView()
}
