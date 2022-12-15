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
        print("Firebase")
    }
    
    @IBAction func signInButtonPressed(_ sender : UIButton) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }

}

