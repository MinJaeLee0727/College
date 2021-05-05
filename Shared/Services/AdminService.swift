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
    
    
    static func reset() {
        for schoolInfo in Constants.SchoolInformation.defaultUniversityList {
            let ref = db.collection("universities").document(schoolInfo.name)
            guard let dict = try? schoolInfo.asDictionary() else {return}
            batch.setData(dict, forDocument: ref)
        }
        
        for school in Constants.SchoolInformation.defaultUniversityList {
            for defaultMotherBoard in Constants.BoardInformation.defaultMotherBoardList {
                guard let dict = try? defaultMotherBoard.asDictionary() else {return}

                let ref = db.collection("universities").document(school.name).collection("motherBoards").document(defaultMotherBoard.name)
                batch.setData(dict, forDocument: ref)
                batch.updateData(["university": school.name], forDocument: ref)
            }
        }
        
        for school in Constants.SchoolInformation.defaultUniversityList {
            for defaultBoard in Constants.BoardInformation.defaultBoardList {
                let ref = db.collection("universities").document(school.name).collection("boards").document(defaultBoard.name)
                
                guard let dict = try? defaultBoard.asDictionary() else {return}
                batch.setData(dict, forDocument: ref)
                batch.updateData(["university": school.name], forDocument: ref)
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

    static func resetSchool() {
        for schoolInfo in Constants.SchoolInformation.defaultUniversityList {
            let ref = db.collection("universities").document(schoolInfo.name)
            guard let dict = try? schoolInfo.asDictionary() else {return}
            batch.setData(dict, forDocument: ref)

//            batch.setData(["name": String(schoolInfo["Name"]!), "number_of_student": 0], forDocument: nycRef)
//            batch.updateData(["number_of_student": FieldValue.delete()], forDocument: ref)
//            batch.updateData(["domain": schoolInfo.domain], forDocument: ref)
        }

        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
            }
        }
    }
    
    
    static func resetMotherBoards() {

        for school in Constants.SchoolInformation.defaultUniversityList {
            for defaultMotherBoard in Constants.BoardInformation.defaultMotherBoardList {
                guard let dict = try? defaultMotherBoard.asDictionary() else {return}

                let ref = db.collection("universities").document(school.name).collection("motherBoards").document(defaultMotherBoard.name)
                batch.setData(dict, forDocument: ref)
                batch.updateData(["university": school.name], forDocument: ref)
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
    
    static func resetDefaultBoards1() {
        
        for school in Constants.SchoolInformation.defaultUniversityList[...10] {
            for defaultBoard in Constants.BoardInformation.defaultBoardList {
                let ref = db.collection("universities").document(school.name).collection("boards").document(defaultBoard.name)
                
                guard let dict = try? defaultBoard.asDictionary() else {return}
                batch.setData(dict, forDocument: ref)
                batch.updateData(["university": school.name], forDocument: ref)
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
    
    static func resetDefaultBoards2() {
        
        for school in Constants.SchoolInformation.defaultUniversityList[11...] {
            for defaultBoard in Constants.BoardInformation.defaultBoardList {
                let ref = db.collection("universities").document(school.name).collection("boards").document(defaultBoard.name)
                
                guard let dict = try? defaultBoard.asDictionary() else {return}
                batch.setData(dict, forDocument: ref)
                batch.updateData(["university": school.name], forDocument: ref)
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
    
    static func resetPosts() {
        
        for school in Constants.SchoolInformation.defaultUniversityList {
            for defaultBoard in Constants.BoardInformation.defaultBoardList {
                let ref = db.collection("[POSTS] \(school.name)").document(defaultBoard.name)
                batch.setData([:], forDocument: ref)

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
    
    static func resetComments() {
        
        for school in Constants.SchoolInformation.defaultUniversityList {
            for defaultBoard in Constants.BoardInformation.defaultBoardList {
                let ref = db.collection("[COMMENTS] \(school.name)").document(defaultBoard.name)
                batch.setData([:], forDocument: ref)
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
