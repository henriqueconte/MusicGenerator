//
//  Alerts.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 10/10/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    // Shows default alert
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Shows alert with text input, where the user can enter information
    func presentAlertWithInput(title: String, message: String, completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0]
            
            completion(textField?.text ?? "failed to get input")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Shows an alert with the list of files found on documents directory
    func presentAlertWithListOfFiles(fileNameList: [String], completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: "Arquivos disponíveis", message: nil, preferredStyle: .alert)
        
        for fileName in fileNameList {
            alert.addAction(UIAlertAction(title: fileName, style: .default, handler: { _ in
                
                completion(fileName)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
}
