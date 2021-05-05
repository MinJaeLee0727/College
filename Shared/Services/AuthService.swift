//
//  File.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/04.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService {
    static var storeRoot = Firestore.firestore()
    
//    static func getVerifiedUser_s(university: String, userId: String) -> DocumentReference {
//        return storeRoot.collection("users").document(university).collection("users").document(userId)
//    }
//
//    static func getVerifiedUser(userId: String, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ errorMesssage: String) -> Void) {
//
//        var user: UserModel
//
//        storeRoot.collectionGroup("users").whereField("uid", isEqualTo: userId).getDocuments {
//            (snapshot, error) in
//
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//
//            guard let snap = snapshot else {
//                onError("There is no user")
//                return
//            }
//
//            if snap.documents.count > 1 {
//                print("UID duplicate")
//                return
//            }
//
//            for doc in snap.documents {
//                let dict = doc.data()
//                guard let decoder = try? UserModel.init(fromDictionary: dict) else {return}
//
//                user = decoder
//            }
//
//            onSuccess(user)
//        }
//    }
//
//    static func getNonVerifiedUser(userId: String) -> DocumentReference {
//        return storeRoot.collection("non-verified users").document(userId)
//    }
    
    static func getUser(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    static func signUp(firstName: String, lastName: String, nickName: String, verified: Bool, major: String, year: Int, email: String, userType: Int, university: String, universityIndex: Int, branchSchool: String, password: String, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (authResult, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            // sending Verification Link ...
            authResult?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                guard let userId = authResult?.user.uid else {return}
                
                let userDoc = getUser(userId: userId)
                
                let user = UserModel.init(uid: userId, firstName: firstName, lastName: lastName, nickName: nickName, verified: verified, school: university, branchSchool: branchSchool, schoolIndex: universityIndex, major: major, year: year, email: email, userType: userType, likedBoards: [])
                                
                guard let dict = try?user.asDictionary() else {return}
                
                userDoc.setData(dict) {
                    (error) in
                    if error != nil {
                        onError(error!.localizedDescription)
                        return
                    }
                    
                    if verified {
                        let schoolDocRef = storeRoot.collection("universities").document(university)
                        
                        if userType == 0 {
                            schoolDocRef.updateData(["number_of_undergraduate_students": FieldValue.increment(Int64(1))])
                        } else if userType == 1 {
                            schoolDocRef.updateData(["number_of_graduate_students": FieldValue.increment(Int64(1))])
                        } else if userType == 2 {
                            schoolDocRef.updateData(["number_of_phd_students": FieldValue.increment(Int64(1))])
                        } else if userType == 3 {
                            schoolDocRef.updateData(["number_of_staff": FieldValue.increment(Int64(1))])
                        }
                    }
                    
                    onSuccess(user)
                    
                }
            })
            
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (authResult, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authResult?.user.uid else {return}
            
            if (authResult?.user.isEmailVerified != nil) {
                if (authResult?.user.isEmailVerified == true) {
                    
                    getUser(userId: userId).getDocument {
                        (document, error) in
                        
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                        
                        if let dict = document?.data() {
                            guard let decodedUser = try? UserModel.init(fromDictionary: dict) else {
                                print("CANNOT DECODE")
                                return
                            }
                            
                            onSuccess(decodedUser)
                        } else {
                            onError("Something Wrong")
                        }
                    }
                }
            }
        }
    }
}

