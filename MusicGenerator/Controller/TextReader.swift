//
//  TextReader.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 21/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


class TextReader {
    
    var notes: [Character] = ["A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f", "G", "g"]
    var stringCount: Int = 0
    var lastRead: Character = " "
    let soundPlayer = SoundPlayer()
    let semaphore = DispatchSemaphore(value: 0)
    
    func read(_ currentString: String) {
        
        let stringArray = Array(currentString)
        stringCount = 0
        
        for i in 0..<currentString.count {

            // Last character
            if i + stringCount + 1 == currentString.count {
                
                let stringPart = [
                    stringArray[currentString.count - 1]
                ]
                
                parseText(stringPart)
                resetPlayer()
                break
            }
            
            // Last two characters
            if i + stringCount + 2 == currentString.count {
                
                let stringPart = [
                    stringArray [i + stringCount],
                    stringArray[i + stringCount + 1]
                ]
                
                parseText(stringPart)
                semaphore.wait()
            }
            
            // First character
            else if i == 0 {
                
                let stringPart = [
                    stringArray[i + stringCount],
                    stringArray[i + stringCount + 1]
                ]
            
                parseText(stringPart)
                semaphore.wait()
            }
        
            // Other options
            else {
                let stringPart = [
                    stringArray[i + stringCount - 1],
                                  stringArray[i + stringCount],
                                  stringArray[i + stringCount + 1]
                ]
                
                parseText(stringPart)
                semaphore.wait()
            }
            
        }
        
    }
    
    func parseText(_ charsArray: [Character]) {
        
        // If it is the last character from the text
        if charsArray.count == 1 {
            
            let finalString = String(charsArray[0])
            playNote(from: finalString)
      
        }
        
        // If it is the first two or last two characters from the text
        else if charsArray.count == 2 {
            
            if ((charsArray[0] == "B" || charsArray[0] == "O") && (charsArray[1] == "+" || charsArray[1] == "-")) ||
            (charsArray[1] == "N" && charsArray[2] == "L" ) {
                
                var finalString: String = ""
                finalString.append(charsArray[0])
                finalString.append(charsArray[1])
                
                stringCount += 1
                
                playNote(from: finalString)
                
                lastRead = charsArray[1]
            }
            else {
                
                let finalString = String(charsArray[0])
                
                playNote(from: finalString)
                
                lastRead = charsArray[0]
            }
            
        }
            
        // If it is any character between the two firsts and two lasts
        else if charsArray.count == 3 {
            
            if ((charsArray[1] == "B" || charsArray[1] == "O") && (charsArray[2] == "+" || charsArray[2] == "-")) ||
               (charsArray[1] == "N" && charsArray[2] == "L" ) {
                
                var finalString: String = ""
                finalString.append(charsArray[1])
                finalString.append(charsArray[2])
                
                stringCount += 1
                
                playNote(from: finalString)
                
                lastRead = charsArray[2]
            }
            
            else {
                let finalString = String(charsArray[1])
                
                lastRead = charsArray[0]
                
                playNote(from: finalString)
                
                lastRead = charsArray[1]
            }
        }
        
    }
    
    func playNote(from letter: String) {
        if letter == "A" || letter == "a" {
            //print("A")
            soundPlayer.play(noteName: "A", completion: {
                self.semaphore.signal()
            })
        }
        
        // Si
        else if letter == "B" || letter == "b" {
            soundPlayer.play(noteName: "B", completion: {
                self.semaphore.signal()
            })
        }
        
        // Dó
        else if letter == "C" || letter == "c" {
            soundPlayer.play(noteName: "C", completion: {
               self.semaphore.signal()
            })
        }
            
        // Ré
        else if letter == "D" || letter == "d" {
            soundPlayer.play(noteName: "D", completion: {
                self.semaphore.signal()
            })
        }
        
        // Mi
        else if letter == "E" || letter == "e" {
            soundPlayer.play(noteName: "E", completion: {
                self.semaphore.signal()
            })
        }
        
        // Fá
        else if letter == "F" || letter == "f" {
            soundPlayer.play(noteName: "F", completion: {
                self.semaphore.signal()
            })
        }
            
        // Sol
        else if letter == "G" || letter == "g" {
            soundPlayer.play(noteName: "G", completion: {
                self.semaphore.signal()
            })
        }
        
        // Silence
        else if letter == " " {
            soundPlayer.silence(completion: {
                self.semaphore.signal()
            })
        }
        
        // Double volume
        else if letter == "+" {
            soundPlayer.increaseVolume()
            self.semaphore.signal()
        }
        
        // Half volume
        else if letter == "-" || letter == "—" {
            soundPlayer.resetVolume()
            self.semaphore.signal()
        }
        
        // Increase BPM
        else if letter == "B+" {
            print("B+")
            self.semaphore.signal()
        }
        
        // Decrease BPM
        else if letter == "B-" {
            print("B-")
            self.semaphore.signal()
        }
        
        // Increases octave
        else if letter == "O+" {
            print("O+")
            self.semaphore.signal()
        }
            
        // Decreases octave
        else if letter == "O-" {
            print("O-")
            self.semaphore.signal()
        }
            
        // Random note
        else if letter == "?" || letter == "." {
            let randomNote = String(notes.randomElement() ?? "a")
            playNote(from: randomNote)
            
            self.semaphore.signal()
        }
            
        // Change instrument
        else if letter == "NL" {
            soundPlayer.toggleInstrument()
            
            self.semaphore.signal()
        }
        
        // Double volume
        else if letter == "O" || letter == "o" || letter == "I" || letter == "i" || letter == "U" || letter == "u" {
            
            if notes.contains(lastRead) {
                playNote(from: String(lastRead))
            }
            else {
                // silence
                soundPlayer.silence {
                    self.semaphore.signal()
                }
            }
            print("OIU")
        }
        
        // None of the above characters
        else {
            print("none")
        }
    }
    
    func resetPlayer() {
        lastRead = Character(".")
        stringCount = 0
        soundPlayer.resetVolume()
        
        semaphore.wait()
    }
    
}
