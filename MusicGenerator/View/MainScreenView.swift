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
    
    let textGenerator = TextGenerator()
    let textReader = TextReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextfield.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButton(_ sender: Any) {
        let receivedText = textGenerator.generateText()
        
        inputTextfield.text = receivedText
    }
    
    @IBAction func play(_ sender: Any) {
        let currentText = inputTextfield.text
        
        textReader.read(currentText ?? "")
    }
    

}

extension MainScreenView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

