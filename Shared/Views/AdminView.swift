//
//  AdminView.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/30.
//

import SwiftUI

struct AdminView: View {
    
    var body: some View {
        VStack {
            
//            Button(action: AdminService.buildSchool) {
//                Text("reset School")
//            }
//
//            Button(action: AdminService.buildDefaultMotherBoards) {
//                Text("reset MotherBoards")
//            }
            
            Button(action: AdminService.buildDefaultBoards) {
                Text("reset boards")
            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
