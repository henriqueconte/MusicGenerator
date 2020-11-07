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
    private var currentInstrument: Instruments = .guitar
    private var volume: Float = 0.1
    private var canPlay: Bool = true
    
    init() {
         // 1: conecta os componentes na nossa engine de som
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)
        
        // 2: conecta as partes entre si para o output se uma ser o input da outra
        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
        
        engine.prepare()
        try? engine.start()
        
    }
    
    func play(noteName: String, completion: @escaping () -> ()) {
        
        if canPlay {
            print("playing")
            let noteFileName = currentInstrument.rawValue + noteName
            let audioFile = try? AVAudioFile(forReading: URL(fileURLWithPath: Bundle.main.path(forResource: noteFileName, ofType: "m4a")!))
            let buffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat, frameCapacity: AVAudioFrameCount(audioFile!.length))

            audioPlayer.volume = volume
            
            audioPlayer.scheduleFile(audioFile!, at: nil)
            audioPlayer.scheduleBuffer(buffer!) {
                completion()
            }
            
            try? engine.start()
            audioPlayer.play()
        }
        else {
            completion()
        }
    }
    
    func silence(completion: @escaping () -> ()) {
        
        print("silence")
        if canPlay {
            let audioFile = try? AVAudioFile(forReading: URL(fileURLWithPath: Bundle.main.path(forResource: "silenceNote", ofType: "mp3")!))
            let buffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat, frameCapacity: AVAudioFrameCount(audioFile!.length))
            
            audioPlayer.scheduleFile(audioFile!, at: nil)
            audioPlayer.scheduleBuffer(buffer!, completionHandler: {
                completion()
            })
            
            try? engine.start()
            audioPlayer.play()
        }
        else {
            completion()
        }

    }
    
    func changeInstrument(to newInstrument: Instruments) {
        currentInstrument = newInstrument
    }
    
    func changeToRandomInstrument() {
        currentInstrument = Instruments.getRandomInstrument()
    }
    
    func increaseVolume() {
        volume = volume * 2
        
        if volume > 1 {
            resetVolume()
        }
    }
    
    func mute() {
        volume = 0
    }
    
    func increaseOctave() {
        pitchControl.pitch += 250
        if pitchControl.pitch > 1500 {
            resetPitch()
        }
    }
    
    func decreaseOctave() {
        pitchControl.pitch -= 250
    }
    
    func increaseBPM() {
        pitchControl.rate += 0.5
    }
    
    func decreaseBPM() {
        pitchControl.rate -= 0.5
        
        if pitchControl.rate < 0.1 {
            pitchControl.rate = 0.1
        }
    }
    
    func resetVolume() {
        volume = 0.1
    }
    
    func resetPitch() {
        pitchControl.pitch = 0
    }
    
    func resetBPM () {
        pitchControl.rate = 1
    }
    
    func stopPlaying() {
        audioPlayer.stop()
        canPlay = false
    }
    
    func allowPlaying() {
        canPlay = true
    }
    
}
