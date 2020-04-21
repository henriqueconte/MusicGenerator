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
    
    func read(_ currentString: String) {
        
        let stringArray = Array(currentString)
        
        for i in 0..<currentString.count {
            
            // Last character
            if i + stringCount + 1 == currentString.count {
                
                let stringPart = [stringArray[i + stringCount]]
                
                print(stringPart)
                
            //    parseText(stringPart)
                
                break
            }
            
            // Last two characters
            if i + stringCount + 2 == currentString.count {
                
                let stringPart = [stringArray [i + stringCount - 1], stringArray[i + stringCount]]
                
                print(stringPart)
                
             //   parseText(stringPart)
            }
            
            // First character
            else if i == 0 {
                
                let stringPart = stringArray[(i + stringCount)...(i + stringCount + 1)]
                
                print(stringPart)
            
            //    parseText(stringPart)
            }
        
            // Other options
            else {
                let stringPart = stringArray[(i + stringCount - 1)...(i + stringCount + 1)]
                
                print(stringPart)
                //parseText(stringPart)
            }
            
        }
        
    }
    
    func parseText(_ charsArray: [Character]) {
        
        // Lá
        if charsArray[1] == "A" || charsArray[1] == "a" {
            
        }
        
        // Si
        else if charsArray[1] == "B" || charsArray[1] == "b" {
            
            if charsArray.count > 1 {
                if charsArray[2] == "+" {
                    
                }
                else if charsArray[2] == "-" {
                    
                }
            }
        }
        
        // Dó
        else if charsArray[1] == "C" || charsArray[1] == "c" {
            
        }
            
        // Ré
        else if charsArray[1] == "D" || charsArray[1] == "d" {
            
        }
        
        // Mi
        else if charsArray[1] == "E" || charsArray[1] == "e" {
            
        }
        
        // Fá
        else if charsArray[1] == "F" || charsArray[1] == "f" {
            
        }
            
        // Sol
        else if charsArray[1] == "G" || charsArray[1] == "g" {
            
        }
        
        // Silence
        else if charsArray[1] == " " {
            
        }
        
        // Double volume
        else if charsArray[1] == "+" {
            
        }
        
        // Half volume
        else if charsArray[1] == "-" {
            
        }
        
        else if charsArray[1] == "O" {
            if charsArray.count > 1 {
                if charsArray[2] == "+" {
                    
                }
                else if charsArray[2] == "-" {
                    
                }
            }
        }
            
        else if charsArray[1] == "?" || charsArray[1] == "." {
            
        }
        
        // Double volume
        else if charsArray[1] == "O" || charsArray[1] == "o" || charsArray[1] == "I" || charsArray[1] == "i" || charsArray[1] == "U" || charsArray[1] == "u" {
            
            if notes.contains(charsArray[0]) {
                // play lastread
            }
            else {
                // silence
            }
        }
        
    }
    
}
