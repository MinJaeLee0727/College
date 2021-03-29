//
//  PostView.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardView: View {
    @ObservedObject var postCardService = PostCardService()
    
    @State private var animate = false
    private let duration: Double = 0.3
    private var animationScale: CGFloat {
        postCardService.isLiked ? 0.5 : 2.0
    }
    
    init(post: postModel) {
        self.postCardService.post = post
        self.postCardService.hasLikedPost()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            //Header
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60, alignment: .center)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Anonymous")
                        .font(.headline)
                    
                    Text((Date(timeIntervalSince1970: self.postCardService.post.date)).timeAgo() + " ago")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                .padding(.leading, 10)
            }
            .padding(.leading)
            .padding(.top, 16)
            
            Text(self.postCardService.post.title)
                .font(.title)
                .lineLimit(nil)
                .foregroundColor(.primary)
            
            Text(self.postCardService.post.content)
                .font(.body)
                .lineLimit(nil)
                .foregroundColor(.primary)
            
            WebImage(url: URL(string: self.postCardService.post.mediaUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: .center)
                .clipped()
            
            //Like Dislike
            HStack(spacing: 15) {
                Button(action: {
                    if self.postCardService.isLiked {
                        self.postCardService.undo()
                    } else {
                        self.postCardService.like()
                    }
                }) {
                    VStack {
                        Image(systemName: (self.postCardService.isLiked) ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .rotationEffect(.degrees(180))
                        
                        if (self.postCardService.post.likeCount > 0) {
                            Text("\(self.postCardService.post.likeCount)")
                        }
                    }
                        
                }
                .padding()
                .scaleEffect(animate ? animationScale : 1)
                .animation(.easeIn(duration: duration))
                
                Button(action: {
                    if self.postCardService.isDisLiked {
                        self.postCardService.undo()
                    } else {
                        self.postCardService.dislike()
                    }
                }) {
                    VStack {
                        Image(systemName: (self.postCardService.isDisLiked) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                            .rotationEffect(.degrees(180))
                        
                        if (self.postCardService.post.dislikeCount > 0) {
                            Text("\(self.postCardService.post.dislikeCount)")
                        }
                    }
                }
                .padding()
                .scaleEffect(animate ? animationScale : 1)
                .animation(.easeIn(duration: duration))
            }
            
            Divider()
                .padding([.leading, .trailing], 5)
            
            //Commments
            
        }
        
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
