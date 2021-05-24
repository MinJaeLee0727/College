//
//  ProfileSevice.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation

class LoadPostsService: ObservableObject {
    
    @Published var posts: [GeneralPostModel] = []

    func loadUserAllPosts(university: String, userId: String) {
        DataBaseService.loadUserPosts_s(university: university, userId: userId) {
            (posts) in
            self.posts = posts
        }
    }
    
    func loadPosts_board(university: String, board: String) {
        DataBaseService.loadPosts_sb(university: university, board: board) {
            (posts) in
            self.posts = posts
        }
    }
}
