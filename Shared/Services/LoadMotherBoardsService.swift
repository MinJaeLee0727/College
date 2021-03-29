//
//  loadBoardsService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation

class LoadMotherBoardsService: ObservableObject {
    
    @Published var motherBoards: [motherBoardModel] = []
    
    func loadMotherBoards(school: String, userId: String) {
        PostService.getMotherBoards(school: school) {
            (motherBoards) in
            
            self.motherBoards = motherBoards.sorted(by: { $0.priority < $1.priority })
    
        }
    }
}
