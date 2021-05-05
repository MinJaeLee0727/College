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

    static func savePostPhoto(university: String, motherBoard: String, board: String, userId: String, title: String, content: String, postId: String, imageData: Data, anonymous: Bool, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMesssage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagePostRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef = DataBaseService.posts_sb(university: university, board: board).document(postId)

                    let post = GeneralPostModel.init(university: university, motherBoard: motherBoard, board: board, posterId: userId, postId: postId, date: Date().timeIntervalSince1970, title: title, content: content, mediaUrl: metaImageUrl, views: 0, likes: [userId:0], likeCount: 0, dislikeCount: 0, number_of_comments: 0, number_of_reports: 0, anonymous: anonymous, removed: false)
                    
                    guard let dict = try? post.asDictionary() else {return}
                    
                    firestorePostRef.setData(dict) {
                        (error) in
                        
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                        
                        CommentService.commentsId(university: university, board: board, postId: postId).setData([:])
                        DataBaseService.loadBoard(university: university, board: board).updateData(["number_of_posts": FieldValue.increment(Int64(1))])
                        onSuccess()
                    }
                }
            }
        }
    }
    
}
