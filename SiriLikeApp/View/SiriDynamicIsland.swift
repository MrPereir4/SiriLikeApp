//
//  SiriDynamicIsland.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 21/01/25.
//

import SwiftUI

struct SiriDynamicIsland: View {
    
    
    @Binding var siriStatus: SiriStatus
    
    var dynamicIslandHeight: CGFloat = 37
    var dynamicIslandWidth: CGFloat = 125
    
    @State var expandableButtonWidth: CGFloat = 0.0
    @State var maskTimer: Float = 0.0
    
    
    
    private var siriAnimationScale: CGFloat {
        switch self.siriStatus {
        case .thinking:
            return 1.0
        case .disabled:
            return 0.5
        }
    }
    
    private var islandStrokeBlur: CGFloat {
        switch self.siriStatus {
        case .thinking:
            return 3
        case .disabled:
            return 25
        }
    }
    
    private var islandStrokeOpacity: CGFloat {
        switch self.siriStatus {
        case .thinking:
            return 1.0
        case .disabled:
            return 0.0
        }
    }
    
    private var dynamicIslandShadowBlur: CGFloat {
        switch self.siriStatus {
        case .thinking:
            return 25
        case .disabled:
            return 0
        }
    }
    
    private var dynamicIslandShadowOpacity: CGFloat {
        switch self.siriStatus {
        case .thinking:
            return 0.9
        case .disabled:
            return 0.0
        }
    }
    
    var body: some View {
        ZStack {
            Group {
                MeshGradientView(maskTimer: self.$maskTimer, gradientSpeed: .constant(0.1))
                    .scaleEffect(1.3)
                    .mask(
                        RoundedRectangle(cornerRadius: 60)
                            .frame(width: dynamicIslandWidth + 30 + expandableButtonWidth, height: dynamicIslandHeight + 30)
                        
                    )
                    .blur(radius: dynamicIslandShadowBlur)
                    .opacity(dynamicIslandShadowOpacity)
                
                MeshGradientView(maskTimer: self.$maskTimer, gradientSpeed: .constant(0.1))
                    .scaleEffect(1.3)
                    .mask(
                        RoundedRectangle(cornerRadius: 60)
                            .frame(width: dynamicIslandWidth + 10 + expandableButtonWidth, height: dynamicIslandHeight + 10)
                        
                    )
                    .blur(radius: self.islandStrokeBlur)
                    .opacity(self.islandStrokeOpacity)
            }
            .scaleEffect(self.siriAnimationScale)
            .animation(.easeOut(duration: 0.3), value: self.siriStatus)
            
            Capsule()
                .fill(.black)
                .frame(width: self.dynamicIslandWidth + expandableButtonWidth)
                .frame(height: dynamicIslandHeight)
        }
        .onTapGesture(perform: {
            switch self.siriStatus {
            case .thinking:
                self.siriStatus = .disabled
            case .disabled:
                self.siriStatus = .thinking
            }
            
        })
        .frame(width: self.dynamicIslandWidth, height: self.dynamicIslandHeight)
        .onChange(of: self.siriStatus) { _, newValue in
            withAnimation(.bouncy(duration: 0.3, extraBounce: 0.4)) {
                switch newValue {
                case .thinking:
                    self.expandableButtonWidth = 40
                case .disabled:
                    self.expandableButtonWidth = 0
                }
            }
        }
    }
}


#Preview {
    SiriDynamicIsland(siriStatus: .constant(.disabled))
}
