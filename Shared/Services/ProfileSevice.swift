//
//  ProfileSevice.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation

class ProfileService: ObservableObject {
    
    @Published var posts: [postModel] = []
    
    func loadUserPosts(school: String, userId: String) {
        
        PostService.getMotherBoards(school: school) {
            (motherBoards) in
            
            for motherboard in motherBoards {
                PostService.getAllBoardsInMotherBoards(school: school, motherBoard: motherboard) {
                    PostService.loadUserPosts(school: school, motherBoard: motherboard, board: board, userId: userId) {
                        (posts) in
                        
                        self.posts.append(posts)
                    }
                }
            }
        }
    }
}
