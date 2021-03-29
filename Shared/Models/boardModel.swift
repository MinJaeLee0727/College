//
//  boardModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/23.
//

import Foundation
import FirebaseFirestore

struct boardModel: Encodable, Decodable {

    var name: String
    var subtitle: String
    
    var school: String
    var motherBoard: String
    
    var priority: Int // 0 ~
    var count: Int
    var countHotPosts: Int
    var userDefined: Bool
    
    
//    var template: String
}
