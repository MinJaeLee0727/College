//
//  Chat.swift
//  college
//
//  Created by Min Jae Lee on 2021/05/13.
//

import Foundation
import Firebase

struct Chat: Encodable, Decodable, Hashable {
    var messageId: String
    var textMessage: String
    var profile: String
    var photoUrl: String
    var sender: String
    var timestamp: Double
    var isCurrentUser: Bool {
        return Auth.auth().currentUser!.uid == sender
    }
    var isPhoto: Bool
    
}
