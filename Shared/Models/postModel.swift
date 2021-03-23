//
//  postModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/19.
//

import Foundation
import FirebaseFirestore

struct PostModel: Encodable, Decodable {
    
    var posterId: String
    var postId: String
    var title: String
    var content: String
    var likes: [String: Bool]
    var mediaUrl: String
    var date: Double
    var likeCount: Int
    var dislikeCount: Int
}
