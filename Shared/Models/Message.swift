//
//  Message.swift
//  college
//
//  Created by Min Jae Lee on 2021/05/13.
//

import Foundation

struct Message: Encodable, Decodable, Identifiable {
    var id = UUID()
    var lastMessage: String
    var username: String
    var isPhoto: Bool
    var timestamp: Double
    var userId: String
    var profile: String
    
}
