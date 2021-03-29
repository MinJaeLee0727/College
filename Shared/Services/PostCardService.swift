//
//  PostCardService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/28.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService: ObservableObject {
    
    @Published var post: postModel!
    @Published var isLiked = false
    @Published var isDisLiked = false
    
    func hasLikedPost() {
        if post.likes["\(Auth.auth().currentUser!.uid)"] == 1 {
            isLiked = true
        } else if post.likes["\(Auth.auth().currentUser!.uid)"] == -1 {
            isDisLiked = true
        }
    }
    
    // func hasSavedPost() {}
    
    
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        PostService.PostsUserId(school: post.school, motherBoard: post.motherBoard, board: post.board, userId: post.posterId).collection("posts").document(post.posterId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 1])
        
        PostService.allPosts(school: post.school).document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 1])
        
        PostService.timelineUserId(school: post.school, userId: post.posterId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 1])
    }
    
    func dislike() {
        post.likeCount -= 1
        isLiked = true
        
        PostService.PostsUserId(school: post.school, motherBoard: post.motherBoard, board: post.board, userId: post.posterId).collection("posts").document(post.posterId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": -1])
        
        PostService.allPosts(school: post.school).document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": -1])
        
        PostService.timelineUserId(school: post.school, userId: post.posterId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": -1])
    }
    
    func undo() {
        if isLiked {
            post.likeCount -= 1
            PostService.PostsUserId(school: post.school, motherBoard: post.motherBoard, board: post.board, userId: post.posterId).collection("posts").document(post.posterId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 0])
            
            PostService.allPosts(school: post.school).document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 0])
            
            PostService.timelineUserId(school: post.school, userId: post.posterId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 0])
        } else if isDisLiked {
            post.likeCount += 1
            PostService.PostsUserId(school: post.school, motherBoard: post.motherBoard, board: post.board, userId: post.posterId).collection("posts").document(post.posterId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 0])
            
            PostService.allPosts(school: post.school).document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 0])
            
            PostService.timelineUserId(school: post.school, userId: post.posterId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": 0])
        }
    }
}
