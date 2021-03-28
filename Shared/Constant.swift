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
        static let UniversityList = [University_Algoma, University_Brock, University_Carleton, University_Guelph, University_Lakehead, University_Laurentian, University_McMaster,
                                     University_Nipissing, University_OCAD, University_OntarioTech, University_Ottawa, University_Queens, University_RMC, University_Ryerson,
                                     University_Toronto, University_Trent, University_Waterloo, University_Western, University_Laurier, University_Windsor, University_York]
        
        static let University_Algoma = ["Name": "Algoma University", "Domain": "@algomau.ca"]
        static let University_Brock = ["Name": "Brock University", "Domain": "@brocku.ca"]
        static let University_Carleton = ["Name": "Carleton University", "Domain": "@carleton.ca"]
        static let University_Guelph = ["Name": "University of Guelph", "Domain": "@uoguleph.ca"]
        static let University_Lakehead = ["Name": "Lakehead University", "Domain": "@lakeheadu.ca"]
        static let University_Laurentian = ["Name": "Lauretian University", "Domain": "@laurentian.ca"]
        static let University_McMaster = ["Name": "McMaster University", "Domain": "@mcmaster.ca"]
        static let University_Nipissing = ["Name": "Nipissing University", "Domain": "@nipissingu.ca"]
        static let University_OCAD = ["Name": "OCAD University", "Domain": "@ocadu.ca"]
        static let University_OntarioTech = ["Name": "Ontario Tech University", "Domain": "@ontariotechu.ca"]
        static let University_Ottawa = ["Name": "University of Ottawa", "Domain": "@uottawa.ca"]
        static let University_Queens = ["Name": "Queen's University", "Domain": "@queensu.ca"]
        static let University_RMC = ["Name": "Royal Military Colllege of Canada", "Domain": "@rmc.ca"]
        static let University_Ryerson = ["Name": "Ryerson University", "Domain": "@ryerson.ca"]
        static let University_Toronto = ["Name": "University of Toronto", "Domain": "@utoronto.ca"]
        static let University_Trent = ["Name": "Trent University", "Domain": "@trentu.ca"]
        static let University_Waterloo = ["Name": "University of Waterloo", "Domain": "@uwaterloo.ca"]
        static let University_Western = ["Name": "Western University", "Domain": "@uwo.ca"]
        static let University_Laurier = ["Name": "Wilfrid Laurier University", "Domain": "@wlu.ca"]
        static let University_Windsor = ["Name": "University of Windsor", "Domain": "@uwindsor.ca"]
        static let University_York = ["Name": "York University", "Domain": "@yorku.ca"]




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
    
    struct boards {
        // motherBoard: [board]
        static let boards = ["Free-Posting" : ["Freshman Board", "Graduate Board", "Open Board", "Undergraduate Board"]]
    }
}
