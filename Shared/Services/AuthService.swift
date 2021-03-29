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
    
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("allUsers").document(userId)
    }
    
    static func getUserIdInSchool(school: String, userId: String) -> DocumentReference {
        return storeRoot.collection("Universities").document(school).collection("users").document(userId)
    }
    
    static func signUp(email: String, school: String, schoolIndex: Int, password: String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
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
                
                let firestoreUserId = getUserId(userId: userId)
                let firestoreUserIdInSchool = getUserIdInSchool(school: school, userId: userId)
                let user = User.init(uid: userId, email: email, school: school, schoolIndex: schoolIndex)
                let schoolDocRef = storeRoot.collection("Universities").document(school)
                
                guard let dict = try?user.asDictionary() else {return}
                
                firestoreUserId.setData(dict) {
                    (error) in
                    if error != nil {
                        onError(error!.localizedDescription)
                        return
                    }
                    
                    firestoreUserIdInSchool.setData(dict) {
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                        
                        schoolDocRef.getDocument {
                            (document, err) in
                            
                            if let dict = document?.data() {
                                guard let decodedSchool = try? schoolModel.init(fromDictionary: dict) else {return}
                                
                                let current_number_of_students = decodedSchool.number_of_students + 1
                                
                                schoolDocRef.setData(["number_of_student": current_number_of_students]) {
                                    (err) in
                                    
                                    if err != nil {
                                        onError(err!.localizedDescription)
                                        return
                                    }
                                    
                                    onSuccess(user)
                                }
                            }
                        }
                        
                    }
                }
                
            })
            
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (authResult, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authResult?.user.uid else {return}
            
            if ((authResult?.user.isEmailVerified) != nil) {
                
                let firestoreUserId = getUserId(userId: userId)
                
                firestoreUserId.getDocument {
                    (document, error) in
                    if let dict = document?.data() {
                        guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                        
                        onSuccess(decodedUser)
                    }
                }
                
            } else {
                onError(error!.localizedDescription)
                return
            }
            
        }
    }
}

