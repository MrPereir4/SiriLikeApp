//
//  RippleEffect.metal
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 20/01/25.
//

#include <SwiftUI/SwiftUI.h>
using namespace metal;

[[stitchable]]
half4 Ripple(float2 position,
             SwiftUI::Layer layer,
             float2 origin,
             float time,
             float amplitude,
             float frequency,
             float decay,
             float speed) {
    
    float distance = length(position - origin);
    float delay = distance / speed;
    
    time -= delay;
    time = max(0.0, time);

    
    float rippleAmount = amplitude * sin(frequency * time) * exp(-decay * time);
    
    //N is the distance from the origin to the current position
    float2 n = normalize(position - origin);
    float2 newPosition = position + rippleAmount * n;
    
    half4 color = layer.sample(newPosition);
    color.rgb += 1.0 * (rippleAmount / amplitude) * color.a;
    return color;
    
}

