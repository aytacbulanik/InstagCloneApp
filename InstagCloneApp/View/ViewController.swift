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
            uyariVer(message: "Alanlar Boş Olamaz")
        }else {
            Auth.auth().signIn(withEmail: mail, password: password) {
                authResult,error in
                if error != nil {
                    self.uyariVer(message: error?.localizedDescription ?? "Bilinmiyor")
                } else {
                   performSegue(withIdentifier: "toHome", sender: nil)
                }
            }
        }
        
        
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    func uyariVer(message : String) {
        let alert = UIAlertController(title: "Dikkat !!!", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

