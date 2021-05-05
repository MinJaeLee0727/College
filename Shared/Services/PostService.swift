//
//  PostCardService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/28.
//

import Foundation
import Firebase
import SwiftUI

class PostService: ObservableObject {
    
    @Published var post: GeneralPostModel!
    @Published var isLiked = false
    @Published var isDisLiked = false

    func hasLikedPost() {
        
        if post.likes["\(Auth.auth().currentUser?.uid ?? "ERROR")"] == 1 {
            isLiked = true
            isDisLiked = false
        } else if post.likes["\(Auth.auth().currentUser?.uid ?? "ERROR")"] == -1 {
            isDisLiked = true
            isLiked = false
        } else {
            isDisLiked = false
            isLiked = false
        }
    }
    
    // func hasSavedPost() {}
    
    func like() {        
        isLiked = true
        isDisLiked = false
        post.likeCount += 1
        DataBaseService.posts_sb(university: post.university, board: post.board).document(post.postId).updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser?.uid ?? "ERROR")": 1])
    }
    
    func dislike() {
        isLiked = false
        isDisLiked = true
        post.dislikeCount += 1
        
        DataBaseService.posts_sb(university: post.university, board: post.board).document(post.postId).updateData(["dislikeCount": post.dislikeCount, "likes.\(Auth.auth().currentUser?.uid ?? "ERROR")": -1])
    }
    
    func undo() {
        if isLiked && !isDisLiked {
            isLiked = false
            isDisLiked = false
            post.likeCount -= 1
            
            DataBaseService.posts_sb(university: post.university, board: post.board).document(post.postId).updateData(["likeCount":  post.likeCount, "likes.\(Auth.auth().currentUser?.uid ?? "ERROR")": 0])
        } else if isDisLiked && !isLiked {
            isLiked = false
            isDisLiked = false
            post.dislikeCount -= 1
            DataBaseService.posts_sb(university: post.university, board: post.board).document(post.postId).updateData(["dislikeCount": post.dislikeCount, "likes.\(Auth.auth().currentUser?.uid ?? "ERROR")": 0])
        
        }
    }
    
    func remove() {
        DataBaseService.posts_sb(university: post.university, board: post.board).document(post.postId).updateData(["removed": true])
    }
    
    func report() {
        DataBaseService.posts_sb(university: post.university, board: post.board).document(post.postId).updateData(["reportCount": FieldValue.increment(Int64(1))])
    }
}
