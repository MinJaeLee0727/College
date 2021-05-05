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

class DataBaseService {
    
    // s: school / m: motherBoard / b : board / u : userId

    static func posts_sb(university: String, board: String) -> CollectionReference {
        
        return AuthService.storeRoot.collection("[POSTS] " + university).document(board).collection("posts")
    }
    
    //
    
    static func getAllBoards_s(university: String, onSuccess: @escaping(_ board: [BoardModel]) -> Void) {
        
        var boards = [BoardModel]()
        
        AuthService.storeRoot.collection("universities").document(university).collection("boards").getDocuments {
            (snapshot, erorr) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? BoardModel.init(fromDictionary: dict) else {return}

                boards.append(decoder)
            }
            
            onSuccess(boards)
        }
        
    }
    
    static func getAllBoards_sm(university: String, motherBoard: String, onSuccess: @escaping(_ board: [BoardModel]) -> Void) {
        AuthService.storeRoot.collection("universities").document(university).collection("boards").whereField("motherBoard", isEqualTo: motherBoard).order(by: "priority").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("[ERROR] getAllBoards_sm:")
                print(error!.localizedDescription)
                return
            }
            
            var boards = [BoardModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? BoardModel.init(fromDictionary: dict)
                
                else {return}
                
                boards.append(decoder)
            }
            
            onSuccess(boards)
        }
    }
    
    static func getMotherBoards_s(university: String, onSuccess: @escaping(_ motherBoard: [MotherBoardModel]) -> Void) {
        AuthService.storeRoot.collection("universities").document(university).collection("motherBoards").order(by: "priority").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var motherBoards = [MotherBoardModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? MotherBoardModel.init(fromDictionary: dict)
                
                else {return}
                
                motherBoards.append(decoder)
            }
            
            onSuccess(motherBoards)
        }
    }
    
    //
//    static var posts = AuthService.storeRoot.collection("posts")
    
    static func uploadPost(university: String, motherBoard: String, board: String, title: String, content: String, imageData: Data, anonymous: Bool, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = posts_sb(university: university, board: board).document().documentID
        
        if imageData.isEmpty {
            
            let firestorePostRef = DataBaseService.posts_sb(university: university, board: board).document(postId)
            
            let post = GeneralPostModel.init(university: university, motherBoard: motherBoard, board: board, posterId: userId, postId: postId, date: Date().timeIntervalSince1970, title: title, content: content, mediaUrl: "", views: 0, likes: [userId: 0], likeCount: 0, dislikeCount: 0, number_of_comments: 0, number_of_reports: 0, anonymous: anonymous, removed: false)
            
            guard let dict = try? post.asDictionary() else {
                print("Cannot convert to dict")
                return
            }
            
            firestorePostRef.setData(dict) {
                (error) in
                
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                CommentService.commentsId(university: university, board: board, postId: postId).setData([:])
                loadBoard(university: university, board: board).updateData(["number_of_posts": FieldValue.increment(Int64(1))])
                onSuccess()
            }
            
        }  else {
            
            let storagePostRef = StorageService.storagePostId(postId: postId)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageService.savePostPhoto(university: university, motherBoard: motherBoard, board: board, userId: userId, title: title, content: content, postId: postId, imageData: imageData, anonymous: anonymous, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
            
        }
    }
    
    static func loadUser_AllPosts_s(university: String, userId: String, onSuccess: @escaping(_ posts: [GeneralPostModel]) -> Void) {

        AuthService.storeRoot.collectionGroup("posts").whereField("posterId", isEqualTo: userId).whereField("removed", isEqualTo: false).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("ERROR")
                return
            }
            
            var posts = [GeneralPostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? GeneralPostModel.init(fromDictionary: dict) else {return}
                
                posts.append(decoder)
                
            }
            onSuccess(posts)
        }
    }
    
    static func loadUserPosts_sbu(university: String, board: String, userId: String, onSuccess: @escaping(_ posts: [GeneralPostModel]) -> Void) {
        posts_sb(university: university, board: board).order(by: "date").whereField("posterId", isEqualTo: userId).whereField("removed", isEqualTo: false).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [GeneralPostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? GeneralPostModel.init(fromDictionary: dict) else {return}
                
                posts.append(decoder)
                
            }
            onSuccess(posts)
        }
    }
    
    // Main
    static func loadPosts_sb(university: String, board: String, onSuccess: @escaping(_ posts: [GeneralPostModel]) -> Void) {
        DataBaseService.posts_sb(university: university, board: board).order(by: "date", descending: true).whereField("removed", isEqualTo: false).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [GeneralPostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? GeneralPostModel.init(fromDictionary: dict)
                
                else {
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }

    
    static func getAllPosts_school(school: String, onSuccess: @escaping(_ posts: [GeneralPostModel]) -> Void) {
        AuthService.storeRoot.collectionGroup("posts").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("ERROR")
                return
            }
            
            var posts = [GeneralPostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? GeneralPostModel.init(fromDictionary: dict)
                
                else {
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
    static func getAllUniversities(onSuccess: @escaping(_ school: [SchoolModel]) -> Void) {
        AuthService.storeRoot.collection("universities").order(by: "name").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var universities = [SchoolModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? SchoolModel.init(fromDictionary: dict)
                
                else {
                    return
                }
                
                universities.append(decoder)
            }
            
            onSuccess(universities)
        }
    }
    
    static func getUndergraduatePrograms(university: String, onSuccess: @escaping(_ programs: [String]) -> Void) {
        
        AuthService.storeRoot.collection("universities").document(university).getDocument {
            (document, error) in
            var programs = [String]()

            if let document = document {
                let dict = document.data()
                guard let decoder = try? SchoolModel.init(fromDictionary: dict) else {return}
                programs = decoder.undergraduatePrograms
            }
            
            onSuccess(programs)
        }
    }
    
    static func loadBoard(university: String, board: String) -> DocumentReference {
        AuthService.storeRoot.collection("universities").document(university).collection("boards").document(board)
    }
}
