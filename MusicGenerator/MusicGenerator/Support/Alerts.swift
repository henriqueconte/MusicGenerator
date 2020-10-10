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
    
    func presentAlertWithInput(title: String, message: String, completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            completion(textField?.text ?? "failed to get input")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
