//
//  SignUpVC.swift
//  InstagCloneApp
//
//  Created by aytaç bulanık on 16.12.2022.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {

    @IBOutlet var mailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordAgainField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        guard let mail = mailField.text , let password = passwordField.text , let password1 = passwordAgainField.text else {return}
        
        if mail.isEmpty || password.isEmpty || password1.isEmpty {
            print("İşleri boş")
            return
        }
        if password != password1 {
            print("şifreler eşit değil")
            return
        }
        Auth.auth().createUser(withEmail: mail, password: password1) {
            (result,error) in
            if error == nil {
                print("bir hata oluştu", error?.localizedDescription ?? "Bilinmiyor")
            }
            
            
        }
    }
    

}
