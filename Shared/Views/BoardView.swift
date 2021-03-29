//
//  Board.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/24.
//

import SwiftUI

struct BoardView: View {
    @State var schoolName: String
    @State var motherBoard: motherBoardModel
    @State var board: boardModel
    
    @StateObject var loadPostsService = LoadPostsService()

    var body: some View {
        
        NavigationView {
            
            ScrollView {
                VStack {
                    ForEach(self.loadPostsService.posts, id: \.postId) {
                        (post) in
                        
                        PostPreview(post: post)
                        Divider()
                            .padding(4)
                    }
                }
            }
            .onAppear {
                self.loadPostsService.loadPosts_board(school: schoolName, motherBoard: motherBoard.name, board: board.name)
            }
        }
        .navigationTitle("\(board.name)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct PostPreview: View {
    var post: postModel
    
    var body: some View {
        NavigationView{
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

//struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView(schoolName: <#String#>, motherBoard: <#motherBoardModel#>, board: <#boardModel#>)
//    }
//}
