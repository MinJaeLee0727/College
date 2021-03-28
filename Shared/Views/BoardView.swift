//
//  Board.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/24.
//

import SwiftUI

//struct myPostsBoard: View {
//    var body: some View {
//        PostService.loadUserPosts(school: <#T##String#>, motherBoard: <#T##String#>, board: <#T##String#>, userId: <#T##String#>, onSuccess: <#T##([PostModel]) -> Void#>)
//    }
//}

struct Board: View {
    var body: some View {
//        PostPreview(post: <#PostModel#>)
        Divider()
            .padding(4)
    }
}

struct PostPreview: View {
    var post: postModel
    
    var body: some View {
        NavigationView() {
            VStack {
                HStack {
                    Text(post.title)
                        .lineLimit(1)
                        .font(.title3)
                        
                    Spacer()
                }
                
                Text(post.content)
                    .lineLimit(1)
                    .font(.caption)
                
                HStack {
//                    Text(Date(timeIntervalSince1970: post.date).timeAgo() + " ago")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack {
                        Text("Likes")
                        Text("Commnets")
                    }
                }
                
            }
        }
    }
}

struct Post: View {
    var body: some View {
        Text("")
    }
}
struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board()
    }
}
