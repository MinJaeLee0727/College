//
//  schoolModel.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation
import FirebaseFirestore

struct SchoolModel: Encodable, Decodable {

    var name: String
    var schoolIndex: Int
    var domain: String
    
    var number_of_undergraduate_students: Int
    var number_of_graduate_students: Int
    var number_of_phd_students: Int
    var number_of_staff: Int
    
    var branchSchools: [String]
    
    var undergraduatePrograms: [String]
    var courses: [String]
    
    var postCount: Int

}
