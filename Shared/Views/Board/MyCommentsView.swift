//
//  MyCommentsView.swift
//  college
//
//  Created by Min Jae Lee on 2021/05/05.
//

import SwiftUI

struct MyCommentsView: View {
    
    @EnvironmentObject var session: SessionStore
    @StateObject var loadPostsService = LoadPostsService()
    
    @ObservedObject var postService = PostService()
    
    @State private var removeAlert = false
    
    func remove(post: GeneralPostModel) {
        self.postService.post = post
        self.removeAlert = true
    }
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    if (!self.loadPostsService.posts.isEmpty) {
                        ForEach(self.loadPostsService.posts, id:\.postId) {
                            (post) in
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    PostPreview(post: post, option: true)
                                        .frame(width: UIScreen.main.bounds.width)
                                    
                                    Button(action: {remove(post: post)}) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.primary)
                                            .background(
                                                RoundedRectangle(cornerRadius: 5.0)
                                                    .foregroundColor(.red)
                                                    .frame(width: 55, height: 55))
                                    }
                                    .padding(.leading)
                                }
                            }
                            
                            Divider()
                                .padding([.leading, .trailing], 5)
                        }
                    }
                    
                    Text("There is no more post.")
                        .padding(.top)
                    
                }
            }
        }
        .alert(isPresented: $removeAlert) {
            Alert(
                title: Text("Are you sure you want to delete this?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    self.postService.remove()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationTitle("My Posts")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            self.loadPostsService.loadUserAllPosts(university: session.user_session?.school ?? "ERROR", userId: session.user_session?.uid ?? "ERROR")
        }
    }
}

struct MyCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCommentsView()
    }
}
