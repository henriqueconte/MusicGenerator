//
//  MusicGeneratorTests.swift
//  MusicGeneratorTests
//
//  Created by Henrique Figueiredo Conte on 12/11/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import XCTest
@testable import MusicGenerator

class MusicGeneratorTests: XCTestCase {
    
    var soundPlayer: SoundPlayer!

    override func setUp() {
        soundPlayer = SoundPlayer()
    }
    
    func testChangeInstrument() {
        
        let expectedInstrument: Instruments = .saxophone
        
        XCTAssertEqual(soundPlayer.currentInstrument, .guitar)
    
        soundPlayer.changeInstrument(to: expectedInstrument)
    
        XCTAssertEqual(soundPlayer.currentInstrument, .saxophone)
    }

    func testIncreaseVolume() {
        let currentExpectedVolume: Float = 0.1
        let firstExpectedVolume: Float = 0.2
        let secondExpectedVolume: Float = 0.4
        
        XCTAssertEqual(currentExpectedVolume, soundPlayer.volume)
        
        soundPlayer.increaseVolume()
        
        XCTAssertEqual(firstExpectedVolume, soundPlayer.volume)
        
        soundPlayer.increaseVolume()
        
        XCTAssertEqual(secondExpectedVolume, soundPlayer.volume)
    }
    
    func testResetVolume() {
        let expectedVolume: Float = 0.1
        
        soundPlayer.resetVolume()
        
        XCTAssertEqual(expectedVolume, soundPlayer.volume)
    }
    
    func testMuteVolume() {
        let expectedVolume: Float = 0.0
        
        soundPlayer.mute()
        
        XCTAssertEqual(expectedVolume, soundPlayer.volume)
    }
    
    func testIncreaseOctave() {
        let expectedPitch: Float = 250
        let currentPitch: Float = 0
        
        XCTAssertEqual(soundPlayer.pitchControl.pitch, currentPitch)
        
        soundPlayer.increaseOctave()
        
        XCTAssertEqual(soundPlayer.pitchControl.pitch, expectedPitch)
    }
    
    func testDecreaseOctave() {
        let expectedPitch: Float = -250.0
        let currentPitch: Float = 0.0
        
        XCTAssertEqual(soundPlayer.pitchControl.pitch, currentPitch)
        
        soundPlayer.decreaseOctave()
        
        XCTAssertEqual(soundPlayer.pitchControl.pitch, expectedPitch)
    }
    
    func testIncreaseBPM() {
        let expectedRate: Float = 1.5
        let currentRate: Float = 1.0
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, currentRate)
        
        soundPlayer.increaseBPM()
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, expectedRate)
    }
    
    func testDecreaseBPM() {
        let minimumRate: Float = 0.1
        let expectedRate: Float = 0.5
        let currentRate: Float = 1.0
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, currentRate)
        
        soundPlayer.decreaseBPM()
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, expectedRate)
        
        soundPlayer.decreaseBPM()
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, minimumRate)
    }
    
    func testResetPitch() {
        let expectedPitch: Float = 0.0
        let currentPitch: Float = 250.0
        
        soundPlayer.increaseOctave()
        
        XCTAssertEqual(soundPlayer.pitchControl.pitch, currentPitch)
        
        soundPlayer.resetPitch()
        
        XCTAssertEqual(soundPlayer.pitchControl.pitch, expectedPitch)
    }
    
    func testResetBPM() {
        let expectedBPM: Float = 1.0
        let currentBPM: Float = 1.5
        
        soundPlayer.increaseBPM()
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, currentBPM)
        
        soundPlayer.resetBPM()
        
        XCTAssertEqual(soundPlayer.pitchControl.rate, expectedBPM)
    }
    
    func testStopPlaying() {
        soundPlayer.stopPlaying()
        
        XCTAssertFalse(soundPlayer.canPlay)
    }
    
    func testAllowPlaying() {
        soundPlayer.allowPlaying()
        
        XCTAssertTrue(soundPlayer.canPlay)
    }
}
