//
//  DynamicIslandHelper.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 21/01/25.
//

import Foundation
import UIKit
import SwiftUI

func getDynamicIslandCenter(in screenSize: CGSize) -> CGPoint? {
    
    guard let keyWindow = UIApplication.shared.connectedScenes
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .first(where: {$0.isKeyWindow}) else {
        return nil
    }
    
    let safeAreaInsets = keyWindow.safeAreaInsets
    let topInset = safeAreaInsets.top
    
    let islandHeight: CGFloat = 40.0
    
    let centerX = screenSize.width / 2
    let centerY = topInset - (islandHeight / 2) - 16
    
    return CGPoint(x: centerX, y: centerY)
    
}
