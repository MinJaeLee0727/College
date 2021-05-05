//
//  PostPreviewView.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/31.
//

import SwiftUI

struct PostPreview: View {
    var post: GeneralPostModel
    var option: Bool
    
    var body: some View {
        NavigationLink(destination: PostCardView(post: post)){
            VStack(alignment: .leading) {
                HStack {
                    Text(post.title)
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(.primary)
                        
                    Spacer()
                }
                HStack {
                    Text(post.content)
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding(.top, 1)
                
                
                HStack {
                    if option {
                        Text(post.board)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    } else {
                        Text(Date(timeIntervalSince1970: post.date).timeAgo())
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color("CollegeStudentRepresentColor"))
                        
                        Text("\(post.likeCount - post.dislikeCount)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .frame(width: 10)
                        
                        Image(systemName: "bubble.right.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color("CollegeStudentRepresentColor"))
                        
                        Text("\(post.number_of_comments)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .frame(width: 10)
                    }
                }
                .padding(.top, 1)
                
            }
            .padding(5)
        }
    }
}


//struct PostPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        PostPreview()
//    }
//}
