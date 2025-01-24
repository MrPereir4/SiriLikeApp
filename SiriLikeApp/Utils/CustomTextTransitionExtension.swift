//
//  CustomTextTransitionExtension.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 22/01/25.
//

import SwiftUI

struct OffsetAndScaleEffect: ViewModifier {
    let offset: CGFloat
    let scale: CGFloat
    let opacity: Double

    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .scaleEffect(scale)
            .opacity(opacity)
    }
}


extension AnyTransition {
    static func customAsymmetricMove(insertionOffset: CGFloat, removalOffset: CGFloat) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: .modifier(
                active: OffsetAndScaleEffect(offset: insertionOffset, scale: 1.0, opacity: 0),
                identity: OffsetAndScaleEffect(offset: 0, scale: 1.0, opacity: 1)
            ),
            removal: .modifier(
                active: OffsetAndScaleEffect(offset: removalOffset, scale: 0.95, opacity: 0),
                identity: OffsetAndScaleEffect(offset: 0, scale: 1.0, opacity: 1)
            )
        )
    }
}
