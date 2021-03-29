//
//  schoolModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation
import FirebaseFirestore

struct schoolModel: Encodable, Decodable {

    var name: String
    var schoolIndex: Int
    var domain: String
    
    var number_of_students: Int
//    var majors: [String]

}
