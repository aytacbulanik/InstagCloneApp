//
//  SettingsVC.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 17.12.2022.
//

import UIKit
import FirebaseAuth

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            do{
                try Auth.auth().signOut()
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let firstVC = storyBoard.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
                firstVC.modalPresentationStyle = .fullScreen
                self.present(firstVC, animated: true)
            } catch {
                print("Kullanıcı çıkışı yapılamadı")
            }
        }
    }
    
}
