//
//  MyPostView.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import SwiftUI
import FirebaseAuth

struct MyPostView: View {
    
    @EnvironmentObject var session: SessionStore
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.profileService.posts, id:\.postId) {
                    (post) in
                    
                    
                }
            }
            
        }
        .onAppear{
            self.profileService.loadUserPosts(school: session.session!.school, userId: Auth.auth().currentUser!.uid)
        }
    }
}

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView()
    }
}
