//
//  TextReader.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 21/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation

// Responsável por ler uma string e interpretar quais ações serão tomadas
class TextReader {
    
    public let soundPlayer = SoundPlayer()
    private(set) var isReading: Bool = false
    private var lastRead: Character = " "
    
    private let uppercasedNotes: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
    private let lowercasedNotes: [Character] = ["a", "b", "c", "d", "e", "f", "g"]
    private let consonantsList: [Character] = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z", "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
    private let numbersList: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var stringCount: Int = 0
    
    private var isLastCharacter: Bool = false
    
    
    private var semaphore = DispatchSemaphore(value: 0)
    
    // Lê uma string e separa em conjuntos de dois e três caracteres, pois podemos ter casos como o NL, e antigamente tinhamos o B+, O+ etc, então é bom estarmos preparados para adicionar funcionalidades que envolvam dois ou três caracteres no futuro.
    func read(_ currentString: String) {
        
        let stringArray = Array(currentString)
        stringCount = 0
        isReading = true
        
        for i in 0..<currentString.count {

            // Último caracter
            if i + stringCount + 1 == currentString.count {
                
                let stringPart = [
                    stringArray[currentString.count - 1]
                ]
                
                isLastCharacter = true
                
                parseText(stringPart)
                
                
                break
            }
            
            // Dois últimos caracteres
            if i + stringCount + 2 == currentString.count {
                
                let stringPart = [
                    stringArray [i + stringCount],
                    stringArray[i + stringCount + 1]
                ]
                
                parseText(stringPart)
                semaphore.wait()
            }
            
            // Primeiro caracter
            else if i == 0 {
                
                let stringPart = [
                    stringArray[i + stringCount],
                    stringArray[i + stringCount + 1]
                ]
            
                parseText(stringPart)
                semaphore.wait()
            }
        
            // Outras opções
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
    
    func parseText(_ charsArray: [Character]) {    // Checa se o caracter é único (Exemplo: D) ou se é composto (Exemplo: B+) e formata para ser lido como um caracter único
        
        // Se é o último caracter do texto
        if charsArray.count == 1 {
            
            let finalString = String(charsArray[0])
            playNote(from: finalString)
      
        }
        
        // Se for os dois primeiros ou dois últimos caracteres do texto
        else if charsArray.count == 2 {
            
            if charsArray[0] == "N" && charsArray[1] == "L"  {
                
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
            
        // Se não é nem os dois primeiros nem os dois últimos caracteres
        else if charsArray.count == 3 {
            
            if charsArray[1] == "N" && charsArray[2] == "L" {
                
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
    
    func playNote(from letter: String) {   // Recebe um caracter e interage com o SoundPlayer para tocar uma nota ou modificar o som
        
        // Lá
        if letter == "A" {
            soundPlayer.play(noteName: "LA", completion: {
                self.semaphore.signal()
            })
        }
        
        // Si
        else if letter == "B" {
            soundPlayer.play(noteName: "SI", completion: {
                self.semaphore.signal()
            })
        }
        
        // Dó
        else if letter == "C" {
            soundPlayer.play(noteName: "DO", completion: {
                self.semaphore.signal()
            })
        }
            
        // Ré
        else if letter == "D" {
            soundPlayer.play(noteName: "RE", completion: {
                self.semaphore.signal()
            })
        }
        
        // Mi
        else if letter == "E" {
            soundPlayer.play(noteName: "MI", completion: {
                self.semaphore.signal()
            })
        }
        
        // Fá
        else if letter == "F" {
            soundPlayer.play(noteName: "FA", completion: {
                self.semaphore.signal()
            })
        }
            
        // Sol
        else if letter == "G" {
            soundPlayer.play(noteName: "SOL", completion: {
                self.semaphore.signal()
            })
        }
        
        // Muda instrumento para o Tubular Bells (que utilizei um similar, chamado Glockenspiel)
        else if letter == "NL" {
            soundPlayer.changeInstrument(to: .glockenspiel)
            semaphore.signal()
        }
        
        // Toca última nota tocada ou silêncio
        else if lowercasedNotes.contains(Character(letter)) || consonantsList.contains(Character(letter)) {
            if uppercasedNotes.contains(lastRead) {
                playNote(from: String(lastRead))
                semaphore.signal()
            }
            else {
                soundPlayer.silence {
                    self.semaphore.signal()
                }
            }
        }
        
        // Silencio
        else if letter == " " {
            soundPlayer.increaseVolume()
            semaphore.signal()
        }
        
        // Muda instrumento para o Agogo (que utilizei um similar, chamado Saxophone)
        else if letter == "!" {
            soundPlayer.changeInstrument(to: .saxophone)
            semaphore.signal()
        }
        
        // Muda instrumento para o Harpsichord (que utilizei um similar, chamado Piano)
        else if letter == "O" || letter == "o" || letter == "I" || letter == "i" || letter == "U" || letter == "u" {
            soundPlayer.changeInstrument(to: .piano)
        }
        
        // Idealmente, deveria mudar para o instrumento General MIDI. Entretanto, como não estou utilizando diretamente os instrumentos do MIDI, irei escolher um instrumento aleatório entre os existentes no projeto.
        else if numbersList.contains(Character(letter)) {
            soundPlayer.changeToRandomInstrument()
            semaphore.signal()
        }
        
        // Aumenta oitava e reseta caso não consiga aumentar mais
        else if letter == "?" {
            soundPlayer.increaseOctave()
            semaphore.signal()
        }
    
        // Muda instrumento para a Pan Flute (que utilizei um similar, chamado Trumpet)
        else if letter == ";" {
            soundPlayer.changeInstrument(to: .harp)
            semaphore.signal()
        }
            
        // Muda instrumento para o Church Organ (que utilizei um similar, chamado Trumpet)
        else if letter == "," {
            soundPlayer.changeInstrument(to: .trumpet)
            semaphore.signal()
        }
    
        // Nenhum dos caracteres acima
        else {
            if uppercasedNotes.contains(lastRead) {
                playNote(from: String(lastRead))
                semaphore.signal()
            }
            else {
                soundPlayer.silence {
                    self.semaphore.signal()
                }
            }
        }
        
        if isLastCharacter {
            resetPlayer()
            isLastCharacter = false
        }
    }
    
    func resetPlayer() {   // Reinicializa o leitor e as configurações de som do SoundPlayer
        lastRead = Character(".")
        stringCount = 0
        isReading = false
        
        soundPlayer.resetVolume()
        soundPlayer.resetPitch()
        soundPlayer.resetBPM()
        
        semaphore = DispatchSemaphore(value: 0)
    }
    
    func stopPlaying() {    // Comunica com o soundPlayer para proibir ele de tocar sons
        soundPlayer.stopPlaying()
    }
    
    func allowPlaying() {    // Comunica com o soundPlayer para permitir ele de tocar sons
        soundPlayer.allowPlaying()
    }
    
}
