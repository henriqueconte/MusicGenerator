//
//  TextGenerator.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 20/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


class TextGenerator { // Responsável pela criação de textos
    
    private let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-?.\\ "
    
    func generateText() -> String { // Gera um texto conforme um conjunto de caracteres existentes
        
        var finalText: String = ""
        
        finalText = String((0..<100).map({ _ in
            (letters.randomElement()!)
        }))
        
        return finalText
    }
}
