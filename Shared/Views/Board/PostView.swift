//
//  PostView.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct PostCardView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionStore

    @ObservedObject var postService = PostService()
    @ObservedObject var commentService = CommentService()
    
    @State private var removeAlert = false
    
    init(post: GeneralPostModel) {
        self.postService.post = post
        self.commentService.post = post
        self.postService.hasLikedPost()
        self.commentService.loadComment(university: self.postService.post.university, board: self.postService.post.board)
    }
    
    func remove() {
        self.removeAlert = true
    }
    
    var body: some View {
        VStack() {
            ScrollView {
                VStack(alignment: .leading) {
                    //Header
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 35, height: 35, alignment: .center)
                            .foregroundColor(self.postService.post.posterId == session.user_session?.uid ? Color("CollegeStudentRepresentColor") : .primary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Anonymous")
                                .font(.headline)
                            
                            Text((Date(timeIntervalSince1970: self.postService.post.date)).timeAgo() + " ago")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        HStack(spacing: 15) {
                            if self.postService.post.posterId == session.user_session?.uid {
                                Button(action: remove, label: {
                                    Image(systemName: "trash")
                                        .font(.system(size: 25, weight: .regular))
                                        .foregroundColor(.primary)
                                })
                            } else {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "bubble.right")
                                        .font(.system(size: 25, weight: .regular))
                                        .foregroundColor(.primary)
                                })
                            }
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "bookmark")
                                    .font(.system(size: 25, weight: .regular))
                                    .foregroundColor(.primary)
                            })
                        }
                    }
                    .frame(height: 30)
                    .padding(.all)
                    
                    Text(self.postService.post.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(nil)
                        .foregroundColor(.primary)
                        .padding(.leading)
                    
                    Text(self.postService.post.content)
                        .font(.body)
                        .lineLimit(nil)
                        .foregroundColor(.primary)
                        .padding([.leading])
                    
                    if (!self.postService.post.mediaUrl.isEmpty) {
                        WebImage(url: URL(string: self.postService.post.mediaUrl)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .center
                            )
                            .clipped()
                            .padding()
                    }
                    
                    //Like Dislike
                    HStack(alignment: .center, spacing: 15) {
                        Spacer()
                        
                        Button(action: {
                            
                            if self.postService.isDisLiked {
                                self.postService.undo()
                            } else if self.postService.isLiked {
                                
                            } else {
                                self.postService.dislike()
                            }
                            
                        }) {
                            VStack {
                                Image(systemName: (self.postService.isDisLiked) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                
                                Text("\(self.postService.post.dislikeCount)")
                            }
                        }
                        .padding()
                        
                        Button(action: {
                            if self.postService.isLiked {
                                self.postService.undo()
                            } else if self.postService.isDisLiked {
                            } else {
                                self.postService.like()
                            }
                            
                        }) {
                            VStack {
                                Image(systemName: (self.postService.isLiked) ? "hand.thumbsup.fill" : "hand.thumbsup")
                                
                                Text("\(self.postService.post.likeCount)")
                                
                            }
                            
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    Divider()
                        .padding([.leading, .trailing], 5)
                    
                    if !self.commentService.comments.isEmpty {
                        ForEach(self.commentService.comments) {
                            (comment) in
                            
                            CommentCardView(comment: comment, posterId: self.postService.post.posterId)
                            
                        }
                    }
                    
                    Spacer(minLength: 10)
                    
                }
            }
            
            VStack(spacing: 0){
                Divider()
                    .foregroundColor(.primary)
                CommentInput(post: self.postService.post)
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
        .onDisappear {
            if self.commentService.listener != nil {
                self.commentService.listener.remove()
            }
        }
    }
}

struct CommentCardView: View {
    var comment: CommentModel
    var posterId: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Auth.auth().currentUser?.uid == comment.ownerId ? Color("CollegeStudentRepresentColor") : .primary)
                
                if (posterId == comment.ownerId) {
                    Text("Anon (OP)")
                        .font(.subheadline)
                        .foregroundColor(Auth.auth().currentUser?.uid == comment.ownerId ? Color("CollegeStudentRepresentColor") : .primary)
                } else {
                    Text("Anon")
                        .font(.subheadline)
                        .foregroundColor(Auth.auth().currentUser?.uid == comment.ownerId ? Color("CollegeStudentRepresentColor") : .primary)
                }
                
                Spacer()
                
                Text((Date(timeIntervalSince1970: comment.date)).timeAgo())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Text(comment.comment)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 3)

    }
}

struct CommentInput: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionStore
    @ObservedObject var commentService = CommentService()
    @State private var text: String = ""
    @State var onEditing = false
    
    init(post: GeneralPostModel) {
        commentService.post = post
    }
    
    func sendComment() { 
        if !text.isEmpty {
            commentService.addComment(comment: text) {
                self.text = ""
            }
        }
    }
    
    var body: some View {
        HStack() {
//            Image(systemName: "person.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .scaledToFit()
//                .clipShape(Circle())
//                .frame(width: 30, height: 30, alignment: .center)
//                .padding(.trailing)\
            
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundColor(Color("CollegeStudentRepresentColor"))
            
            TextField("Insert a comment", text: $text, onEditingChanged: { isEditing in
                self.onEditing = true
            })
            .frame(height: 50)
            .padding(4)
            
            Button(action: sendComment) {
                Image(systemName: "paperplane")
                    .imageScale(.large)
                    .padding(.leading)
            }
            
        }
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 3)
        .background(Color(colorScheme == .light ? .white : .black))
        .navigationBarItems(trailing: Group{
            if onEditing {
                Button(action: {
                    hideKeyboard()
                    self.onEditing = false
                }, label: {
                    Text("Done")
                })
            }
        })

    }
}
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
