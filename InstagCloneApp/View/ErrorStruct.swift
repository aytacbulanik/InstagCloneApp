//
//  ErrorStruct.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 18.12.2022.
//

import Foundation
import UIKit

struct ErrorStruct {
    
    static func uyariVer(message : String) -> UIAlertController {
        let alert = UIAlertController(title: "Dikkat !!!", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        return alert
    }
}
