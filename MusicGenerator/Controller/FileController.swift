//
//  FileManager.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 10/10/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


final class FileController {
    
    func readFile(fileName: String, completion: @escaping (Bool, String) -> ()) {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(false, "")
            return
        }
    
        let fileURL = directory.appendingPathComponent(fileName)
            
        do {
            let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            completion(true, fileContent)
        } catch {
            completion(false, "Error reading file!")
        }
    }
    
    func writeFile(fileName: String, fileContent: String, completion: @escaping (Bool) -> ()) {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = directory.appendingPathComponent(fileName)
        
        do {
            try fileContent.write(to: fileURL, atomically: true, encoding: .utf8)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func getListOfFiles(completion: @escaping (Bool, [String]) -> ()) {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
       
        do {
            let fileURLList: [URL] = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            let fileNames = fileURLList.map { $0.deletingPathExtension().lastPathComponent }
            
            completion(true, fileNames)
        } catch {
            completion(false, [])
        }
        
    }
}
