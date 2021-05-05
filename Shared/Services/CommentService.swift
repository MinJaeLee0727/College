//
//  CommentService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/31.
//

import Foundation
import Firebase

class CommentService: ObservableObject {
    
    // 제공하는 변수들
    @Published var isLoading = false
    @Published var comments: [CommentModel] = []
    
    //받는 변수들
    var listener: ListenerRegistration!
    var post: GeneralPostModel!
    
    static func commentsRef(university: String, board: String) -> CollectionReference {
        return AuthService.storeRoot.collection("[COMMENTS] " + university).document(board).collection("comments-post")
    }
    
    static func commentsId(university: String, board: String, postId: String) -> DocumentReference {
        return commentsRef(university: university, board: board).document(postId)
    }
    
    func postComment(comment: String, ownerId: String, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ error: String) -> Void) {
        
        let comment = CommentModel.init(university: post.university, motherBoard: post.motherBoard, board: post.board, postId: postId, ownerId: ownerId, date: Date().timeIntervalSince1970, comment: comment, likes: [ownerId: 0], likeCount: 0, dislikeCount: 0, number_of_reports: 0)
        
        guard let dict = try? comment.asDictionary() else { return }
        
        CommentService.commentsId(university: post.university, board: post.board, postId: post.postId).collection("comments").addDocument(data: dict) {
            (err) in
            
            if let err = err {
                onError(err.localizedDescription)
                return
            }
            
            DataBaseService.posts_sb(university: self.post.university, board: self.post.board).document(self.post.postId).updateData(["number_of_comments": FieldValue.increment(Int64(1))])
            
            onSuccess()
        }
    }
    
    func getComments(university: String, board: String, postId: String, onSuccess: @escaping(([CommentModel]) -> Void), onError: (_ error: String) -> Void, newComment: @escaping(CommentModel) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        let listernerPosts = CommentService.commentsId(university: university, board: board, postId: postId).collection("comments").order(by: "date", descending: false).addSnapshotListener {
            (snap, err) in
            
            guard let snap = snap else {return}
            
            var comments = [CommentModel]()
            
            snap.documentChanges.forEach {
                (diff) in
                
                if (diff.type == .added) {
                    let dict = diff.document.data()
                    
                    guard let decoded = try? CommentModel.init(fromDictionary: dict) else {return}
                    
                    newComment(decoded)
                    comments.append(decoded)
                }
                
                if (diff.type == .modified) {
                    print("Modified")
                }
                
                if (diff.type == .removed) {
                    print("Removal")
                }
            }
            onSuccess(comments)
            
        }
        listener(listernerPosts)
    }
    
    func loadComment(university: String, board: String) {
        self.comments = []
        self.isLoading = true
        
        self.getComments(university: university, board: board, postId: post.postId, onSuccess: {
            (comments) in
            
            if self.comments.isEmpty {
                self.comments = comments
            }
            
        }, onError: {
            (err) in
        }, newComment: {
            (comment) in
            
            if !self.comments.isEmpty {
                self.comments.append(comment)
            }
        }) {
            (listener) in
            self.listener = listener
        }
    }
    
    
    func addComment(comment: String, onSuccess: @escaping() -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        postComment(comment: comment, ownerId: currentUserId, postId: post.postId, onSuccess: { onSuccess() }) {
            (err) in
            print(err)
        }
     }
}
 
