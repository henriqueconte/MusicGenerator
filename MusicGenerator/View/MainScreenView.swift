//
//  ViewController.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 14/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class MainScreenView: UIViewController {

    @IBOutlet weak private var backgroundImage: UIImageView!
    @IBOutlet weak private var inputTextfield: UITextField!
    @IBOutlet weak private var caseBackgroundImage: UIImageView!
    @IBOutlet weak private var playButton: UIButton!
    @IBOutlet weak private var stopButton: UIButton!
    @IBOutlet weak private var generateSongButton: UIButton!
    @IBOutlet weak private var instructionsButton: UIButton!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var openFileButton: UIButton!
    
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
            
            DispatchQueue.global(qos: .background).async {
                self.textReader.read(currentText ?? "")
            }
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        textReader.stopPlaying()
    }
    
    @IBAction func showInstructionsScreen(_ sender: Any) {
        performSegue(withIdentifier: "showInstructions", sender: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        presentAlertWithInput(title: "Salvar", message: "Insira o nome do arquivo") { [weak self] (inputFileName) in
            guard let self = self else { return }
        
            let textContent: String = self.inputTextfield.text ?? ""
            
            self.fileController.writeFile(fileName: inputFileName, fileContent: textContent, completion: { (hasSucceeded) in
                if !hasSucceeded {
                    self.presentAlert(title: "Erro", message: "Erro ao salvar arquivo!")
                }
            })
        }
    }
    
    @IBAction func openFile(_ sender: Any) {
        fileController.getListOfFiles { [weak self ](hasSucceeded, filesName) in
            guard let self = self else { return }
            
            if hasSucceeded {
                self.presentAlertWithListOfFiles(fileNameList: filesName) { (selectedFileName) in
                    
                    self.fileController.readFile(fileName: selectedFileName) { (isAvailable, fileContent) in
                        
                        if isAvailable {
                            self.inputTextfield.text = fileContent
                        }
                        else {
                            self.presentAlert(title: "Erro", message: "Erro ao carregar arquivo!")
                        }
                    }
                }
            }
            else {
                self.presentAlert(title: "Erro", message: "Erro ao buscar arquivos!")
            }
        }
    }
    
    
}

extension MainScreenView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

