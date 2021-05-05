//
//  LoadSchoolService.swift
//  college
//
//  Created by Min Jae Lee on 2021/04/11.
//

import Foundation

class LoadUniversitiesService: ObservableObject {
    
    @Published var universities: [SchoolModel] = []
    
    func loadUniversities() {
        DataBaseService.getAllUniversities() {
            (universities) in
            
            self.universities = universities
        }
    }
    
    func loadUndergraduatePrograms(university: String) {
        
    }
}
