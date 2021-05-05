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
            
            Button(action: AdminService.reset, label: {
                Text("Reset")
            })
            
            Button(action: AdminService.resetSchool) {
                Text("reset School")
            }

            Button(action: AdminService.resetMotherBoards) {
                Text("reset MotherBoards")
            }
            
            Button(action: AdminService.resetDefaultBoards1) {
                Text("reset boards1")
            }
            
            Button(action: AdminService.resetDefaultBoards2) {
                Text("reset boards2")
            }
            
            Button(action: AdminService.resetPosts) {
                Text("reset posts")
            }
            
            Button(action: AdminService.resetComments) {
                Text("reset comments")
            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
