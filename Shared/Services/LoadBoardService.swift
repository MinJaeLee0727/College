//
//  loadBoardsService.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/29.
//

import Foundation

class LoadBoardService: ObservableObject {
    
    @Published var motherBoards: [MotherBoardModel] = []
    
    func loadMotherBoards(university: String, userId: String) {
        DataBaseService.getMotherBoards_s(university: university) {
            (motherBoards) in
            
            self.motherBoards = motherBoards
    
        }
    }
    
}
