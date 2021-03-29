//
//  motherBoardModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/24.
//

import Foundation
import FirebaseFirestore

struct motherBoardModel: Encodable, Decodable {

    var name: String
    var subtitle: String

    var school: String
    
    var priority: Int
    var count: Int
    var countHotBoards: Int
    var userDefined: Bool
    
}
