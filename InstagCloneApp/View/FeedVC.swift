//
//  FeedVC.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 17.12.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var emailArray = [String]()
    var commentArray = [String]()
    var likeCountArray = [Int]()
    var imageUrlArray = [String]()
    var documendIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getDataFirestore()
    }
    
    func getDataFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapShot, error in
            if error != nil {
                let hata = ErrorStruct.uyariVer(message: "veri Alınamadı")
                self.present(hata, animated: true)
            }else {
                self.imageUrlArray.removeAll()
                self.emailArray.removeAll()
                self.likeCountArray.removeAll()
                self.commentArray.removeAll()
                self.documendIdArray.removeAll()
                
                if snapShot?.isEmpty != true && snapShot != nil {
                    
                    for document in snapShot!.documents {
                        let documentId = document.documentID
                        self.documendIdArray.append(documentId)
                        if let postedBy = document.get("postedBy") as? String {
                            self.emailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.commentArray.append(postComment)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                        if let postLikeCount = document.get("likes") as? Int {
                            self.likeCountArray.append(postLikeCount)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.userMailLabel.text = emailArray[indexPath.row]
        cell.usercommentLabel.text = commentArray[indexPath.row]
        cell.likeCountLabel.text = String(likeCountArray[indexPath.row])
        cell.postImage.sd_setImage(with: URL(string: imageUrlArray[indexPath.row]))
        cell.documentIdLabel.text = documendIdArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
    

}
