//
//  StorageService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/04.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class StorageService {
    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference()
    
    static var storagePost = storageRoot.child("posts")
    
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }

    static func savePostPhoto(school: String, motherBoard: String, board: String, userId: String, title: String, content: String, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMesssage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagePostRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef = PostService.PostsUserId(school: school, motherBoard: motherBoard, board: board, userId: userId).collection("posts").document()

                    let post = postModel.init(school: school, motherBoard: motherBoard, board: board, posterId: userId, postId: postId, date: Date().timeIntervalSince1970, title: title, content: content, mediaUrl: metaImageUrl, likes: [:], likeCount: 0, dislikeCount: 0)
                    
                    guard let dict = try? post.asDictionary() else {return}
                    
                    firestorePostRef.setData(dict) {
                        (error) in
                        
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                        
                        PostService.timelineUserId(school: school, userId: userId).collection("timeline").document(postId).setData(dict)
                        
                        PostService.allPosts(school: school).document(postId).setData(dict)
                        
                        onSuccess()
                    }
                }
            }
        }
    }
    
}
