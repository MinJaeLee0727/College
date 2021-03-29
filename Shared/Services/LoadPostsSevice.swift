//
//  ProfileSevice.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation

class LoadPostsService: ObservableObject {
    
    @Published var posts: [postModel] = []
    
    func loadUserPosts(school: String, userId: String) {
        
//        PostService.getMotherBoards(school: school) {
//            (motherBoards) in
//
//            for motherboard in motherBoards {
//                PostService.getAllBoardsInMotherBoards(school: school, motherBoard: motherboard.name) {
//                    (boards) in
//
//                    for board in boards {
//                        PostService.loadUserPosts(school: school, motherBoard: motherboard.name, board: board.name, userId: userId) {
//                            (loadedPosts) in
//
//                            self.posts.append(contentsOf: loadedPosts)
//                        }
//                    }
//                }
//            }
//        }
        
        PostService.loadUserPosts_stu(school: school, userId: userId) {
            (posts) in
            
            self.posts = posts
        }
    }
    
    func loadPosts_board(school: String, motherBoard: String, board: String) {
        PostService.loadPostsInBoard(school: school, motherBoard: motherBoard, board: board) {
            (posts) in
            self.posts = posts
        }
    }
}
