//
//  PostService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class PostService {
        
    static func allPosts(school: String) -> CollectionReference {
        return AuthService.storeRoot.collection("Universities").document(school).collection("allPosts")
    }
    
    static func Timeline(school: String) -> CollectionReference {
        return AuthService.storeRoot.collection("Universities").document(school).collection("timeline")
    }
    
    static func Posts(school: String, motherBoard: String, board: String) -> CollectionReference {
        return AuthService.storeRoot.collection("Universities").document(school).collection("posts").document(motherBoard).collection("boards").document(board).collection("posts")
    }
    
    static func PostsUserId(school: String, motherBoard: String, board: String, userId: String) -> DocumentReference {
        return Posts(school: school, motherBoard: motherBoard, board: board).document(userId)
    }
    
    static func timelineUserId(school: String, userId: String) -> DocumentReference {
        return Timeline(school: school).document(userId)
    }
    
    static func uploadPostWithImage(school: String, motherBoard: String, board: String, title: String, content: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = PostService.PostsUserId(school: school, motherBoard: motherBoard, board: board, userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(school: school, motherBoard: motherBoard, board: board, userId: userId, title: title, content: content, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
    
//    static func uploadPost(school: String, motherBoard: String, board: String, title: String, content: String, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
//        
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        let postId = PostService.PostsUserId(school: school, motherBoard: motherBoard, board: board, userId: userId).collection("posts").document().documentID
//     
//        let firestorePostRef = PostService.PostsUserId(school: school, motherBoard: motherBoard, board: board, userId: userId).collection("posts").document()
//        
//        let post = PostModel.init(posterId: userId, postId: postId, title: title, content: content, likes: [:], mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0, dislikeCount: 0)
//        
//        guard let dict = try? post.asDictionary() else {return}
//        
//        firestorePostRef.setData(dict) {
//            (error) in
//            
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//            
//            PostService.timelineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
//            
//            PostService.AllPosts.document(postId).setData(dict)
//            
//            onSuccess()
//        }
//    }
    
    static func loadUserPosts_stu(school: String, userId: String, onSuccess: @escaping(_ posts: [postModel]) -> Void) {
        PostService.timelineUserId(school: school, userId: userId).collection("timeline").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [postModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? postModel.init(fromDictionary: dict) else {return}
                
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
    
    static func loadUserPosts_smbu(school: String, motherBoard: String, board: String, userId: String, onSuccess: @escaping(_ posts: [postModel]) -> Void) {
        PostService.PostsUserId(school: school, motherBoard: motherBoard, board: board, userId: userId).collection("posts").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [postModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? postModel.init(fromDictionary: dict) else {return}
                
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
    
    static func loadPostsInBoard(school: String, motherBoard: String, board: String, onSuccess: @escaping(_ posts: [postModel]) -> Void) {
        PostService.Posts(school: school, motherBoard: motherBoard, board: board).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [postModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? postModel.init(fromDictionary: dict)
                
                else {
                    return
                }
                
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
    
    static func getAllBoardsInSchool(school: String, onSuccess: @escaping(_ board: [boardModel]) -> Void) {
        getMotherBoards(school: school) {
            (motherBoards) in
            
            var boards = [boardModel]()
            
            for motherBoard in motherBoards {
                AuthService.storeRoot.collection("Universities").document(school).collection("posts").document(motherBoard.name).collection("boards").getDocuments {
                    (snapshot, erorr) in
                    
                    guard let snap = snapshot else {
                        print("Error")
                        return
                    }
                                        
                    for doc in snap.documents {
                        let dict = doc.data()
                        guard let decoder = try? boardModel.init(fromDictionary: dict)
                        
                        else {return}
                        
                        boards.append(decoder)
                    }
                    
                }
            }
            
            onSuccess(boards)
        }
    }
    
    static func getAllBoardsInMotherBoards(school: String, motherBoard: String, onSuccess: @escaping(_ board: [boardModel]) -> Void) {
        AuthService.storeRoot.collection("Universities").document(school).collection("posts").document(motherBoard).collection("boards").getDocuments {
            (snapshot, erorr) in
            
            var boards = [boardModel]()
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
                                
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? boardModel.init(fromDictionary: dict)
                
                else {return}
                
                boards.append(decoder)
            }
            
            onSuccess(boards)
        }
    }
    
    static func getMotherBoards(school: String, onSuccess: @escaping(_ motherBoard: [motherBoardModel]) -> Void) {
        AuthService.storeRoot.collection("Universities").document(school).collection("posts").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var motherBoards = [motherBoardModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? motherBoardModel.init(fromDictionary: dict)
                
                else {return}
                
                motherBoards.append(decoder)
            }
            
            onSuccess(motherBoards)
        }
    }
    
    static func getAllPosts(school: String, onSuccess: @escaping(_ posts: [postModel]) -> Void) {
        PostService.allPosts(school: school).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [postModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? postModel.init(fromDictionary: dict)
                
                else {return}
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
//    static func getAllSchool(onSuccess: @escaping(_ school: [schoolModel]) -> Void) { }
}
