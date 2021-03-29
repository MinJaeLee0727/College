//
//  LoadBoardsService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation

class LoadBoardsService: ObservableObject {
    
    @Published var boards: [boardModel] = []
    
    func loadBoards(school: String, motherBoard: String, userId: String) {
    
        PostService.getAllBoardsInMotherBoards(school: school, motherBoard: motherBoard) {
            (boards) in
            
            self.boards = boards
        }
    }
}
