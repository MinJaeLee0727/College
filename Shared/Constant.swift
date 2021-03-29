//
//  Constant.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/21.
//

import Foundation
import UIKit

struct Constants {
    
    struct CollegeColor {
        static let CollegeRepresentColor = UIColor(named: "CollegeStudentRepresentColor")
    }
    
    struct SchoolInformation {
        static let defaultUniversityList = [defaultUniversity_Algoma, defaultUniversity_Brock, defaultUniversity_Carleton, defaultUniversity_Lakehead, defaultUniversity_Laurentian, defaultUniversity_McMaster, defaultUniversity_Nipissing, defaultUniversity_OCAD, defaultUniversity_OntarioTech,defaultUniversity_Queens, defaultUniversity_RMC, defaultUniversity_Ryerson, defaultUniversity_Trent, defaultUniversity_Guelph, defaultUniversity_Ottawa, defaultUniversity_Toronto, defaultUniversity_Waterloo, defaultUniversity_Windsor, defaultUniversity_Western, defaultUniversity_Laurier, defaultUniversity_York] // loxi
        
        static let defaultUniversity_Algoma = schoolModel.init(name: "Algoma University", schoolIndex: 0, domain: "@algomau.ca", number_of_students: 0)
        static let defaultUniversity_Brock = schoolModel.init(name: "Brock University", schoolIndex: 1, domain: "@brocku.ca", number_of_students: 0)
        static let defaultUniversity_Carleton = schoolModel.init(name: "Carleton University", schoolIndex: 2, domain: "@carleton.ca", number_of_students: 0)
        static let defaultUniversity_Lakehead = schoolModel.init(name: "Lakehead University", schoolIndex: 3, domain: "@lakeheadu.ca", number_of_students: 0)
        static let defaultUniversity_Laurentian = schoolModel.init(name: "Lauretian University", schoolIndex: 4, domain: "@laurentian.ca", number_of_students: 0)
        static let defaultUniversity_McMaster = schoolModel.init(name: "McMaster University", schoolIndex: 5, domain: "@mcmaster.ca", number_of_students: 0)
        static let defaultUniversity_Nipissing = schoolModel.init(name: "Nipissing University", schoolIndex: 6, domain: "@nipissingu.ca", number_of_students: 0)
        static let defaultUniversity_OCAD =  schoolModel.init(name: "OCAD University", schoolIndex: 7, domain: "@ocadu.ca", number_of_students: 0)
        static let defaultUniversity_OntarioTech = schoolModel.init(name: "Ontario Tech University", schoolIndex: 8, domain: "@ontariotechu.ca", number_of_students: 0)
        static let defaultUniversity_Queens =  schoolModel.init(name: "Queen's University", schoolIndex: 9, domain: "@queensu.ca", number_of_students: 0)
        static let defaultUniversity_RMC = schoolModel.init(name: "Royal Military Colllege of Canada", schoolIndex: 10, domain: "@rmc.ca", number_of_students: 0)
        static let defaultUniversity_Ryerson = schoolModel.init(name: "Ryerson University", schoolIndex: 11, domain: "@ryerson.ca", number_of_students: 0)
        static let defaultUniversity_Trent = schoolModel.init(name: "Trent  University", schoolIndex: 12, domain: "@trentu.ca", number_of_students: 0)
        static let defaultUniversity_Guelph = schoolModel.init(name: "University of Guelph", schoolIndex: 13, domain: "@uoguleph.ca", number_of_students: 0)
        static let defaultUniversity_Ottawa = schoolModel.init(name: "University of Ottawa", schoolIndex: 14, domain: "@uottawa.ca", number_of_students: 0)
        static let defaultUniversity_Toronto = schoolModel.init(name: "University of Toronto", schoolIndex: 15, domain: "@utoronto.ca", number_of_students: 0)
        static let defaultUniversity_Waterloo = schoolModel.init(name: "University of Waterloo", schoolIndex: 16, domain: "@uwaterloo.ca", number_of_students: 0)
        static let defaultUniversity_Windsor = schoolModel.init(name: "University of Windsor", schoolIndex: 17, domain: "@uwindsor.ca", number_of_students: 0)
        static let defaultUniversity_Western = schoolModel.init(name: "Western University", schoolIndex: 18, domain: "@uwo.ca", number_of_students: 0)
        static let defaultUniversity_Laurier = schoolModel.init(name: "Wilfrid Laurier University", schoolIndex: 19, domain: "@wlu.ca", number_of_students: 0)
        static let defaultUniversity_York = schoolModel.init(name: "York University", schoolIndex: 20, domain: "@yorku.ca", number_of_students: 0)

        // , "Programs" : ["AFM", "Architectural Engineering", "Architecture", "Biomedical Engineering", "Biotechnology/CPA", "BA&CS", "BA&Math", "Chemical Engineering", "Civil Engineering", "Computer Engineering", "Computer Science", "]
        
        
        //        Algoma University
        //        Brock University
        //        Carleton University
        //        University of Guelph
        //        University of Guelph - Humber
        //        Université de Hearst – affiliée à l'Université Laurentienne
        //        Lakehead University
        //        Laurentian University
        //        McMaster University
        //        Nipissing University
        //        OCAD University
        //        Ontario Tech University
        //        University of Ottawa
        //        University of Ottawa - Saint Paul University
        //        Queen’s University
        //        Royal Military College of Canada
        //        Ryerson University
        //        University of Toronto
        //        University of Toronto - Mississauga
        //        University of Toronto - Scarborough
        //        University of Toronto - St. George
        //        Trent University
        //        Trent University Durham GTA
        //        University of Waterloo
        //        University of Waterloo - Conrad Grebel University College
        //        University of Waterloo - Renison University College
        //        University of Waterloo - st. Jerome’s University
        //        University of Waterloo - St.Paul’s University College
        //        Western University
        //        Western University - Brescia University College
        //        Western University - Huron University College
        //        Western University - King’s University College
        //        Wilfrid Laurier University
        //        Wilfrid Laurier University - Brantford Campus
        //        Wilfrid Laurier University - Waterloo Campus
        //        University of Windsor
        //        York University
        //        York University - Glendon Campus
        

    }
    
    struct BoardInformation {
        
        static let defaultMotherBoardList = [defaultMotherBoard_FreePosting, defaultMotherBoard_FAQ, defaultMotherBoard_Information, defaultMotherBoard_ETC, defaultMotherBoard_BoardsWithOtherPeople, defaultMotherBoard_BoardsThatWeMade]

        static let defaultMotherBoard_FreePosting = motherBoardModel.init(name: "Free-Posting", subtitle: "Talk whatever you want", school: "ERROR", priority: 0, count: 0, countHotBoards: 0, userDefined: false)

        static let defaultMotherBoard_FAQ = motherBoardModel.init(name: "FAQ", subtitle: "Ask whatever you want", school:  "ERROR", priority:  1, count: 0, countHotBoards: 0, userDefined: false)
        
        static let defaultMotherBoard_Information = motherBoardModel.init(name: "Information", subtitle: "Share whatver information you want", school:  "ERROR", priority:  2, count: 0, countHotBoards: 0, userDefined: false)
        
        static let defaultMotherBoard_ETC = motherBoardModel.init(name: "ETC", subtitle: "And the other things", school:  "ERROR", priority:  3, count: 0, countHotBoards: 0, userDefined: false)
        
        static let defaultMotherBoard_BoardsWithOtherPeople =  motherBoardModel.init(name: "Boards with other people", subtitle: "Talk with whoever you want", school:  "ERROR", priority: 4, count: 0, countHotBoards: 0, userDefined: false)
        
        
        static let defaultMotherBoard_BoardsThatWeMade = motherBoardModel.init(name: "Boards that we made", subtitle: "Create whatever boards you want", school:  "ERROR", priority: 5, count: 0, countHotBoards: 0, userDefined: false)
        
        
        
        static let defaultBoardList = []
        
        static let defaultBoard_OpenBoard = boardModel.init(name: "Open Board", subtitle: "Literally talk whatever you want", school: "ERROR", motherBoard: "Free-Posting", priority: 0, count: 0, countHotPosts: 0, userDefined: false, template: <#T##String#>)
        
    }
}
