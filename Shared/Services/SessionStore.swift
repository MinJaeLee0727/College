//
//  SessionStore.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/04.
//

import Foundation
import Combine
import FirebaseAuth
import Firebase

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet{self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({
            (auth, user) in
            
            if let user = user {
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument{
                    (document, error) in
                    if let dict = document?.data() {
                        guard let decodeduser = try? User.init(fromDictionary: dict) else {return}
                        print(decodeduser)
                        self.session = decodeduser
                    }
                }
            }
            else {
                self.session = nil
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
