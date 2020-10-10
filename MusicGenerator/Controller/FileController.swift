//
//  FileManager.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 10/10/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


final class FileController {
    
    func readFile(fileName: String) -> String {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return "failed finding directory" }
    
        let fileURL = directory.appendingPathComponent(fileName)
            
        do {
            let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            
            return fileContent
        } catch {
            //TODO: PRESENT ALERT
            print("error reading file")
            return "failed reading file"
        }
    }
    
    func writeFile(fileName: String, fileContent: String) {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = directory.appendingPathComponent(fileName)
        
        do {
            try fileContent.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print ("error writing file")
        }
        
    }
}
