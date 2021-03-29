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
    @StateObject var loadPostsService = LoadPostsService()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.loadPostsService.posts, id:\.postId) {
                    (post) in
                    
                    PostCardView(post: post)
                }
            }
            
        }
        .onAppear{
            self.loadPostsService.loadUserPosts(school: session.session!.school, userId: Auth.auth().currentUser!.uid)
        }
    }
}

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView()
    }
}
