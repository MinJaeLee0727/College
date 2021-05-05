//
//  postModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/19.
//

import Foundation
import FirebaseFirestore

struct GeneralPostModel: Encodable, Decodable {
    
    var university: String
    var motherBoard: String
    var board: String
    
    var posterId: String
    var postId: String
    var date: Double
    
    var title: String
    var content: String
    var mediaUrl: String
    
    var views: Int
    var likes: [String: Int] // userId: {-1: disliked / 0: default / 1: liked}
    var likeCount: Int
    var dislikeCount: Int
    
    var number_of_comments: Int
    var number_of_reports: Int
    
    var anonymous: Bool
    var removed: Bool
    
//    var reportCount: Int
}
