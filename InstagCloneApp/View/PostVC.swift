//
//  PostVC.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 17.12.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class PostVC: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var postField: UITextField!
    @IBOutlet var postButonOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(imageGesture)
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageRefrance = storage.reference()
        let mediaFolder = storageRefrance.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let imageUuid = UUID().uuidString
            let imageRefrence = mediaFolder.child("\(imageUuid).jpg")
            imageRefrence.putData(data) { storageData, error in
                if error != nil {
                    let hata = ErrorStruct.uyariVer(message: error?.localizedDescription ?? "Bilinmiyor")
                    self.present(hata, animated: true)
                } else {
                    imageRefrence.downloadURL { url, error in
                        if error != nil {
                            let hata = ErrorStruct.uyariVer(message: error?.localizedDescription ?? "Bilinmiyor")
                            self.present(hata, animated: true)
                        } else {
                            let imageUrl = url?.absoluteString
                            
                            //database
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreRefrence : DocumentReference? = nil
                            let firestorePost = [firebaseFieldConstant.imageUrl : imageUrl!,
                                                 firebaseFieldConstant.postedBy : Auth.auth().currentUser!.email!,
                                                 firebaseFieldConstant.postComment : self.postField.text!,
                                                 firebaseFieldConstant.date : FieldValue.serverTimestamp(),
                                                 firebaseFieldConstant.likes : 0
                            ] as [String:Any]
                            firestoreRefrence = firestoreDatabase.collection(firebaseColConstant.posts).addDocument(data: firestorePost) {
                                error in
                                if error != nil {
                                    let hata = ErrorStruct.uyariVer(message: error?.localizedDescription ?? "Bilinmiyor")
                                    self.present(hata, animated: true)
                                } else {
                                    self.postField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                            
                            
                            
                        }
                    }
                }
            }
        }
        
    }
}
