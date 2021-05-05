//
//  Board.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/24.
//

import SwiftUI

struct BoardView: View {
    @State var schoolName: String
    @State var motherBoard: String
    @State var board: String
    @State var isLoading = true
    @State var isEmpty = false
    
    @StateObject var loadPostsService = LoadPostsService()
    
    var body: some View {
        ZStack() {
            ScrollView{
                VStack {
                    if (!self.loadPostsService.posts.isEmpty) {
                        ForEach(self.loadPostsService.posts, id: \.postId) {
                            (post) in
                            PostPreview(post: post, option: false)
                            
                            Divider()
                                .padding([.leading, .trailing], 5)
                        }
                        
                    }
                    
                    Spacer()
                    
                    Text("There is no more post.")
                }
            }
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: UploadPost(universityName: schoolName, motherBoardName: motherBoard, boardName: board)) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color("CollegeStudentRepresentColor"))
                            .background(
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            )
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            self.loadPostsService.loadPosts_board(university: schoolName, board: board)
        }
        .navigationTitle("\(board)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

//struct BoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardView(schoolName: <#String#>, motherBoard: <#motherBoardModel#>, board: <#boardModel#>)
//    }
//}
