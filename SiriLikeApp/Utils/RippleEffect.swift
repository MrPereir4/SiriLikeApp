//
//  RippleEffect.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 21/01/25.
//

import SwiftUI

struct RippleEffect<T: Equatable>: ViewModifier {
    
    var trigger: T
    var origin: CGPoint
    
    var duration: TimeInterval { 3 }
    
    init(at origin: CGPoint, trigger: T) {
        self.origin = origin
        self.trigger = trigger
    }
    
    func body(content: Content) -> some View {
        
        let origin = self.origin
        let duration = self.duration
        
        content.keyframeAnimator(initialValue: 0.0,
                                 trigger: trigger) { [origin] view, elapsedTime in
            view.modifier(RippleModifier(origin: origin, elapsedTime: elapsedTime, duration: duration))
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }

    }
}
