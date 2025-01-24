//
//  AudioHandler.swift
//  SiriLikeApp
//
//  Created by Vinnicius Pereira on 22/01/25.
//

import Foundation
import AVFoundation

class AudioHandler {
    
    func siriCallAudio() -> AVAudioPlayer? {
        var audioPlayer: AVAudioPlayer?
        
        if let soundURL = Bundle.main.url(forResource: "siriCallSound", withExtension: ".mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                return audioPlayer
            } catch {
                print("Failed to load audio: \(error.localizedDescription)")
            }
        }else {
            print("Couldnt find audio file.")
        }
        
        return nil
    }
    
}
