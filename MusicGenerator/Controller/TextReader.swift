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
    
    
    func read(_ currentString: String) {
        
        let stringArray = Array(currentString)
        stringCount = 0
        
        for i in 0..<currentString.count {
            
            // Finished reading
            if i + stringCount + 1 > currentString.count {
                break
            }

            // Last character
            if i + stringCount + 1 == currentString.count {
                
                let stringPart = [
                    stringArray[currentString.count - 1]
                ]
                
                parseText(stringPart)
            
                break
            }
            
            // Last two characters
            if i + stringCount + 2 == currentString.count {
                
                let stringPart = [
                    stringArray [i + stringCount],
                    stringArray[i + stringCount + 1]
                ]
                
                parseText(stringPart)
            }
            
            // First character
            else if i == 0 {
                
                let stringPart = [
                    stringArray[i + stringCount],
                    stringArray[i + stringCount + 1]
                ]
            
                parseText(stringPart)
            }
        
            // Other options
            else {
                let stringPart = [
                    stringArray[i + stringCount - 1],
                                  stringArray[i + stringCount],
                                  stringArray[i + stringCount + 1]
                ]
                
                parseText(stringPart)
            }
            
        }
        
    }
    
    func parseText(_ charsArray: [Character]) {
        
        // If it is the last character from the text
        if charsArray.count == 1 {
            
            let finalString = String(charsArray[0])
            getNote(from: finalString)
      
        }
        
        // If it is the first two or last two characters from the text
        else if charsArray.count == 2 {
            
            if (charsArray[0] == "B" || charsArray[0] == "O") && (charsArray[1] == "+" || charsArray[1] == "-") {
                
                var finalString: String = ""
                finalString.append(charsArray[0])
                finalString.append(charsArray[1])
                
                stringCount += 1
                
                getNote(from: finalString)
            }
            else {
                
                let finalString = String(charsArray[0])
                
                getNote(from: finalString)
            }
            
        }
            
        // If it is any character between the two firsts and two lasts
        else if charsArray.count == 3 {
            
            if (charsArray[1] == "B" || charsArray[1] == "O") && (charsArray[2] == "+" || charsArray[2] == "-") {
                
                var finalString: String = ""
                finalString.append(charsArray[1])
                finalString.append(charsArray[2])
                
                stringCount += 1
                
                getNote(from: finalString)
            }
            
            else {
                let finalString = String(charsArray[1])
                
                lastRead = charsArray[0]
                
                getNote(from: finalString)
            }
        }
        
    }
    
    func getNote(from letter: String) {
        if letter == "A" || letter == "a" {
            print("A")
        }
        
        // Si
        else if letter == "B" || letter == "b" {
            print("B")
        }
        
        // Dó
        else if letter == "C" || letter == "c" {
            print("C")
        }
            
        // Ré
        else if letter == "D" || letter == "d" {
            print("D")
        }
        
        // Mi
        else if letter == "E" || letter == "e" {
            print("E")
        }
        
        // Fá
        else if letter == "F" || letter == "f" {
            print("F")
        }
            
        // Sol
        else if letter == "G" || letter == "g" {
            print("G")
        }
        
        // Silence
        else if letter == " " {
            print(" ")
        }
        
        // Double volume
        else if letter == "+" {
            print("+")
        }
        
        // Half volume
        else if letter == "-" {
            print("-")
        }
        
        // Increase BPM
        else if letter == "B+" {
            print("B+")
        }
        
        // Decrease BPM
        else if letter == "B-" {
            print("B-")
        }
        
        // Increases octave
        else if letter == "O+" {
            print("O+")
        }
            
        // Decreases octave
        else if letter == "O-" {
            print("O-")
        }
            
        // Random note
        else if letter == "?" || letter == "." {
            print("? .")
        }
        
        // Double volume
        else if letter == "O" || letter == "o" || letter == "I" || letter == "i" || letter == "U" || letter == "u" {
            
            if notes.contains(lastRead) {
                getNote(from: String(lastRead))
            }
            else {
                // silence
            }
            print("OIU")
        }
        
        // None of the above characters
        else {
            print("none")
        }
    }
    
}
