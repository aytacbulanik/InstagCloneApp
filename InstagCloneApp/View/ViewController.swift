//
//  ViewController.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 13.12.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet var nameField : UITextField!
    @IBOutlet var passwordField : UITextField!
    @IBOutlet var girisButtonOut : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(closeTapGesture)
        girisButtonOut.layer.cornerRadius = 8
    }
    
    @IBAction func signInButtonPressed(_ sender : UIButton) {
        guard let mail = nameField.text else {return}
        guard let password = passwordField.text else {return}
        
        if mail.isEmpty || password.isEmpty {
            print("Alanlar boş olamaz")
        } else {
            Auth.auth().signIn(withEmail: mail, password: password) {
                error , result in
                if error == nil {
                    print(error, "bir hata var ")
                    return
                } else {
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            }
        }
        
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
}

