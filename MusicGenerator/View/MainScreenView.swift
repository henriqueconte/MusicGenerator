//
//  ViewController.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 14/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class MainScreenView: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var inputTextfield: UITextField!
    @IBOutlet weak var caseBackgroundImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var generateSongButton: UIButton!
    @IBOutlet weak var instructionsButton: UIButton!
    
    
    let textGenerator: TextGenerator = TextGenerator()
    var textReader: TextReader = TextReader()
    private let fileController: FileController = FileController()
    
    var isReading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextfield.delegate = self
    }

    @IBAction func generateButton(_ sender: Any) {
        let receivedText = textGenerator.generateText()
        
        inputTextfield.text = receivedText
    }
    
    @IBAction func play(_ sender: Any) {
        
        textReader.allowPlaying()
        textReader.soundPlayer.resetVolume()
        
        if textReader.isReading == false {
            let currentText = inputTextfield.text
            fileController.writeFile(fileName: "eugostodebatata.txt", fileContent: currentText ?? "input text field")
            
            DispatchQueue.global(qos: .background).async {
                self.textReader.read(currentText ?? "")
            }
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        print(fileController.readFile(fileName: "eugostodebatata.txt"))
        textReader.stopPlaying()
    }
    
    @IBAction func showInstructionsScreen(_ sender: Any) {
        performSegue(withIdentifier: "showInstructions", sender: nil)
    }
    
    
}

extension MainScreenView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

