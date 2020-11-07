//
//  Instruments.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 23/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


enum Instruments: String, CaseIterable {
    case piano = "piano"
    case guitar = "guitar"
    case glockenspiel = "glockenspiel"
    case harp = "harp"
    case saxophone = "saxophone"
    case trumpet = "trumpet"
    
    static func getRandomInstrument()  ->  Instruments {
        return Instruments.allCases.randomElement() ?? .piano
    }
}
