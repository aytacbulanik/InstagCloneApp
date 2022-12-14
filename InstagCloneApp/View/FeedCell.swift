//
//  FeedCell.swift
//  InstagCloneApp
//
//  Created by aytaç bulanık on 20.12.2022.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    
    @IBOutlet var userMailLabel : UILabel!
    @IBOutlet var usercommentLabel : UILabel!
    @IBOutlet var postImage : UIImageView!
    @IBOutlet var likeCountLabel : UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonCliked(_ sender: UIButton) {
        let fireStoreDataBase = Firestore.firestore()
        if let likeCount = Int(likeCountLabel.text!) {
            let likeData = ["likes" : likeCount + 1] as [String: Any]
            fireStoreDataBase.collection("Posts").document(documentIdLabel.text!).setData(likeData, merge: true)
        }
       
        
        
    }
}
