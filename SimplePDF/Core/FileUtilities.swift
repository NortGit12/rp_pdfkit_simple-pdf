//
//  FileUtilities.swift
//  SimplePDF
//
//  Created by Jeff Norton on 2/13/18.
//  Copyright © 2018 Jeff Norton. All rights reserved.
//

import Foundation

struct FileUtilities {
    
    static func contractsDirectory() -> String {
        let contractsPath = (FileUtilities.documentsDirectory() as NSString).appendingPathComponent("contracts")
        var isDir: ObjCBool = false
        
        if !FileManager.default.fileExists(atPath: contractsPath, isDirectory: &isDir) {
            try? FileManager.default.createDirectory(atPath: contractsPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        return contractsPath
    }
    
    static func documentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
}









