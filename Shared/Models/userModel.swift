//
//  userModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/04.
//

import Foundation

struct User: Encodable, Decodable {
    var uid : String
//    var firstName : String
//    var lastName : String
    var email : String
//    var type : String
    var school : String
    var schoolIndex : Int
//    var major : String
//    var year : String
//    var password : String
}
