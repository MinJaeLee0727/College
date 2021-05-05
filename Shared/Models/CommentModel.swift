//
//  CommentModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/31.
//

import Foundation
import FirebaseFirestore

struct CommentModel: Encodable, Decodable, Identifiable {
    
    var id = UUID()
    
    var university: String
    var motherBoard: String
    var board: String
    var postId: String
    
    var ownerId: String
    
    var date: Double
    
    var comment: String
    
    var likes: [String: Int] // userId: {-1: disliked / 0: default / 1: liked}
    var likeCount: Int
    var dislikeCount: Int
    var number_of_reports: Int
}
