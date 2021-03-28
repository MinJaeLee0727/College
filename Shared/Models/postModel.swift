//
//  postModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/19.
//

import Foundation
import FirebaseFirestore

struct postModel: Encodable, Decodable {
    
    var school: String
    var motherBoard: String
    var board: String
    
    var posterId: String
    var postId: String
    var date: Double
    
    var title: String
    var content: String
    var mediaUrl: String
    
    var likes: [String: Int] // userId: {-1: disliked / 0: -- / 1: liked}
//    var dislikes: [String: Bool]
    var likeCount: Int
    var dislikeCount: Int
}
