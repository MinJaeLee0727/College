//
//  AdminService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/30.
//

import Foundation
import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AdminService {
    
    static let db = AuthService.storeRoot
    static let batch = AuthService.storeRoot.batch()
    
    static func buildSchool() {
        for schoolInfo in Constants.SchoolInformation.UniversityList {
            let ref = db.collection("Universities").document(schoolInfo["Name"]!)
//            batch.setData(["name": String(schoolInfo["Name"]!), "number_of_student": 0], forDocument: nycRef)
//            batch.updateData(["number_of_student": FieldValue.delete()], forDocument: ref)
            batch.updateData(["domain": schoolInfo["Domain"]!], forDocument: ref)
        }

        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
            }
        }
    }
    
    
    static func buildDefaultMotherBoards() {

        for schoolInfo in Constants.SchoolInformation.UniversityList {
            for defaultMotherBoard in Constants.BoardInformation.defaultMotherBoardList {
                let ref = db.collection("Universities").document(schoolInfo["Name"]!).collection("posts").document(defaultMotherBoard.name)

                guard let dict = try? defaultMotherBoard.asDictionary() else {return}

                batch.setData(dict, forDocument: ref)
                batch.updateData(["school": schoolInfo["Name"]!], forDocument: ref)
            }
        }

        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
            }
        }
    }
    
    static func buildDefaultBoards() {
        
        for schoolInfo in Constants.SchoolInformation.UniversityList {
            for defaultMotherboard in Constants.BoardInformation.defaultMotherBoardList {
                
                for 
                let ref = db.collection("Universities").document(schoolInfo["Name"]!).collection("posts").document(defaultMotherboard.name)
                
                guard let dict = try? defaultMotherboard.asDictionary() else {return}
                
                batch.setData(dict, forDocument: ref)
                batch.updateData(["school": schoolInfo["Name"]!], forDocument: ref)
            }
        }

        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
            }
        }
    }
    
    
//    static func buildMotherBoard(name: String, subtitle: String, school: String, priority: Int, count: Int, countHotBoards: Int, userDefined: Bool, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
//
//        let motherBoard = motherBoardModel.init(name: name, subtitle: subtitle, school: school, priority: priority, count: count, countHotBoards: countHotBoards, userDefined: userDefined)
//
//        let firestorePostRef = AuthService.storeRoot.collection("Universities").document(school).collection("posts").document(name)
//
//        guard let dict = try? motherBoard.asDictionary() else {return}
//
//        firestorePostRef.setData(dict) {
//            (error) in
//
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//
//            onSuccess()
//        }
//    }
}
