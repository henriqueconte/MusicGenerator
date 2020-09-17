//
//  TextReader.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 21/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


class TextReader {   // Responsável por ler uma string e interpretar quais ações serão tomadas
    
    var notes: [Character] = ["A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f", "G", "g"]
    var stringCount: Int = 0
    var lastRead: Character = " "
    var isLastCharacter: Bool = false
    var isReading: Bool = false
    let soundPlayer = SoundPlayer()
    var semaphore = DispatchSemaphore(value: 0)
    
    func read(_ currentString: String) {    // Lê uma string e separa em conjuntos de dois e três caracteres
        
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
            
            if ((charsArray[0] == "B" || charsArray[0] == "O") && (charsArray[1] == "+" || charsArray[1] == "-")) ||
            (charsArray[0] == "N" && charsArray[1] == "L" ) {
                
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
    
    func playNote(from letter: String) {   // Recebe um caracter e interage com o SoundPlayer para tocar uma nota ou modificar o som
        
        print(letter)
        if letter == "A" || letter == "a" {
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
        
        // Silencio
        else if letter == " " {
            soundPlayer.silence(completion: {
                self.semaphore.signal()
            })
        }
        
        // Dobra volume
        else if letter == "+" {
            soundPlayer.increaseVolume()
            self.semaphore.signal()
        }
        
        // Reseta volume
        else if letter == "-" || letter == "—" {
            soundPlayer.resetVolume()
            self.semaphore.signal()
        }
        
        // Aumenta BPM
        else if letter == "B+" {
            soundPlayer.increaseBPM()
            self.semaphore.signal()
        }
        
        // Diminui BPM
        else if letter == "B-" {
            soundPlayer.decreaseBPM()
            self.semaphore.signal()
        }
        
        // Aumenta oitava
        else if letter == "O+" {
            soundPlayer.increaseOctave()
            self.semaphore.signal()
        }
            
        // Diminui oitava
        else if letter == "O-" {
            soundPlayer.decreaseOctave()
            self.semaphore.signal()
        }
            
        // Nota aleatória
        else if letter == "?" || letter == "." {
            let randomNote = String(notes.randomElement() ?? "a")
            playNote(from: randomNote)
            
            self.semaphore.signal()
        }
            
        // Muda instrumento
        else if letter == "NL" {
            soundPlayer.toggleInstrument()
            
            self.semaphore.signal()
        }
        
        // Toca ultima nota tocada
        else if letter == "O" || letter == "o" || letter == "I" || letter == "i" || letter == "U" || letter == "u" {
            
            if notes.contains(lastRead) {
                playNote(from: String(lastRead))
                self.semaphore.signal()
            }
            else {
                // silence
                soundPlayer.silence {
                    self.semaphore.signal()
                }
            }
    
        }
        // Nenhum dos caracteres acima
        else {
            self.semaphore.signal()
        }
        
        if isLastCharacter {
            resetPlayer()
            isLastCharacter = false
        }
    }
    
    func resetPlayer() {   // Reinicializa o leitor e as configurações de som do SoundPlayer
        print("reset")
        
        lastRead = Character(".")
        stringCount = 0
        isReading = false
        
        soundPlayer.resetVolume()
        soundPlayer.resetPitch()
        soundPlayer.resetBPM()
        
        semaphore = DispatchSemaphore(value: 0)
    }
    
    func stopPlaying() {    // Comunica com o soundPlayer para proibir ele de tocar sons
        print("stopped?")
        soundPlayer.stopPlaying()
    }
    
    func allowPlaying() {    // Comunica com o soundPlayer para permitir ele de tocar sons
        print("allowed")
        soundPlayer.allowPlaying()
    }
    
}
