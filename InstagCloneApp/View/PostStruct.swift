//
//  PostStruct.swift
//  InstagCloneApp
//
//  Created by AYTAÇ BULANIK on 24.12.2022.
//

import Foundation
import FirebaseDatabaseSwift

struct PostStruct {
    var postedBy : String
    var postComment : String
    var postImageUrl : String
    var postLikeCount : Int
    var postDate : ServerTimestamp
    var postId : String
}
