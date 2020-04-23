//
//  SoundPlayer.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 21/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import AVFoundation
import Foundation


class SoundPlayer {
    
    private let engine = AVAudioEngine()
    private let speedControl = AVAudioUnitVarispeed()
    private let pitchControl = AVAudioUnitTimePitch()
    private let audioPlayer = AVAudioPlayerNode()
    
    init() {
        
         // 1: connect the components to our playback engine
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)
        
        // 2: arrange the parts so that output from one is input to another
        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
        
        engine.prepare()
        try? engine.start()
        
    }
    
    func play(noteName: String) {
        let audioFile = try? AVAudioFile(forReading: URL(fileURLWithPath: Bundle.main.path(forResource: noteName, ofType: "m4a")!))
        
        audioPlayer.volume = 1
        
        audioPlayer.scheduleFile(audioFile!, at: nil)
        
        try? engine.start()
        audioPlayer.play()
    }
}
