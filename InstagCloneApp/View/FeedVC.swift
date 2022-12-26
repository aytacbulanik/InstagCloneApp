//
//  FeedVC.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 17.12.2022.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseDatabaseSwift

class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var postsArray = [PostStruct]()
    
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
                
                self.postsArray.removeAll(keepingCapacity: false)
                
                if snapShot?.isEmpty != true && snapShot != nil {
                    
                    for document in snapShot!.documents {
                        let postId = document.documentID
                        guard let postedBy = document.get(firebaseFieldConstant.postedBy) as? String else {return}
                        guard let postComment = document.get(firebaseFieldConstant.postComment) as? String else {return}
                        guard let imageUrl = document.get(firebaseFieldConstant.imageUrl) as? String else {return}
                        guard let postLikeCount = document.get(firebaseFieldConstant.likes) as? Int else {return}
                        print("--------------")
                        guard let postDate = document.get(firebaseFieldConstant.date) as? Timestamp else {return}
                        let postChangedDate = postDate.dateValue()
                        let newPost = PostStruct(postedBy: postedBy, postComment: postComment, postImageUrl: imageUrl, postLikeCount: postLikeCount, postDate: postChangedDate, postId: postId)
                        self.postsArray.append(newPost)
                    }
                    self.tableView.reloadData()
                    
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        let indexPathRow = postsArray[indexPath.row]
        cell.userMailLabel.text = indexPathRow.postedBy
        cell.usercommentLabel.text = indexPathRow.postComment
        cell.likeCountLabel.text = String(indexPathRow.postLikeCount)
        cell.postImage.sd_setImage(with: URL(string: indexPathRow.postImageUrl))
        cell.documentIdLabel.text = indexPathRow.postId
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
    

}
