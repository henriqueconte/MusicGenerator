//
//  TextGenerator.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 20/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


class TextGenerator {
    
    func generateText() -> String {
        
        var finalText: String = ""
        let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 +-?.\\"
        
        finalText = String((0..<100).map({ _ in
            (letters.randomElement()!)
        }))
        
        return finalText
    }
}
