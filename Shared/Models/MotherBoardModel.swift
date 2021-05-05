//
//  motherBoardModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/24.
//

import Foundation
import FirebaseFirestore

struct MotherBoardModel: Encodable, Decodable {

    var name: String
    var subtitle: String

    var university: String
    
    var priority: Int
    var count: Int
    var countHotBoards: Int
    var userDefined: Bool
    
    var boards: [String]
//    var reference: DocumentReference
}
