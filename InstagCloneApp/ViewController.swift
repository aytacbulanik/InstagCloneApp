//
//  ViewController.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 13.12.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var nameField : UITextField!
    @IBOutlet var passwordField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(closeTapGesture)
    }
    
    @IBAction func signInButtonPressed(_ sender : UIButton) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
}

