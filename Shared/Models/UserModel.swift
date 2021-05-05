//
//  userModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/04.
//

import Foundation

struct UserModel: Encodable, Decodable {
    var uid : String
    
    var firstName : String
    var lastName : String
    var nickName : String
    
    var verified : Bool
    var school : String
    var branchSchool : String
    var schoolIndex : Int
    var major : String
    var year : Int
    var email : String
    
    var userType : Int // {-4: visitor / -3: advertiser / -2: recruiter / -1: highschool student / 0: undergraduate student / 1: graduate student / 2: Ph.D. student / 3: Staff / 4: Others}
    var likedBoards: [String]
}
