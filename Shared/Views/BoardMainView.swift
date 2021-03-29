//
//  BoardView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI
import FirebaseAuth

struct BoardMainView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @StateObject var loadMotherBoardsService = LoadMotherBoardsService()
    
    var body: some View {
        if (session.session != nil) {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    topBoardCard(user: self.session.session)
                    
                    ForEach(self.loadMotherBoardsService.motherBoards, id:\.name) {
                        (motherBoards) in
                        
                        motherBoardCard(schoolName: self.session.session!.school, motherBoard: motherBoards)
                            .padding(.bottom, 5)
                    }
                    
                }
                .onAppear {
                    self.loadMotherBoardsService.loadMotherBoards(school: session.session!.school, userId:  Auth.auth().currentUser!.uid)
                }
                .padding()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarHidden(true)
            }
 
        } else { Text("") }
    }
}

struct topBoardCard: View {
    var user: User?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(
                destination: MyPostView(),
                label: {
                    HStack {
                        Image(systemName: "doc.fill")
                            .foregroundColor(Color("CollegeStudentRepresentColor"))
                            .padding(.trailing, 5)
                        
                        Text("My Posts")
                            .fontWeight(.light)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 20)
                })
            
            HStack {
                Image(systemName: "doc.fill")
                    .foregroundColor(Color("CollegeStudentRepresentColor"))
                    .padding(.trailing, 5)
                
                Text("My Comments")
                    .fontWeight(.light)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 20)
            
            HStack {
                Image(systemName: "doc.fill")
                    .foregroundColor(.yellow)
                    .padding(.trailing, 5)
                
                Text("Saved Post")
                    .fontWeight(.light)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 20)
            
            Divider()
                //                    .padding([.leading, .trailing], 5)
                .padding(.bottom, 20)
            
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .padding(.trailing, 5)
                
                Text("Hot Boards")
                    .fontWeight(.light)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 20)
            
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .padding(.trailing, 5)
                
                Text("Hot Articles")
                    .fontWeight(.light)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 20)
            
        }
        .padding(.top, 20)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.gray), lineWidth: 1)
        )
    }
}

struct motherBoardCard: View {
    
    @StateObject var loadBoardsService = LoadBoardsService()
    @State var schoolName: String
    @State var motherBoard: motherBoardModel
    @State var collapse = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(motherBoard.name)")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    if collapse {
                        Text("\(motherBoard.subtitle)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {self.collapse.toggle()}) {
                    Image(systemName: collapse ? "chevron.up" : "chevron.down")
                        .foregroundColor(.secondary)
                        .font(Font.body.weight(.semibold))
                }
            }
            .padding(.all, 16)
            
            if !collapse {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(self.loadBoardsService.boards, id:\.name) {
                        (boards) in
                        
                        NavigationLink(destination: BoardView(schoolName: schoolName, motherBoard: motherBoard, board: boards)) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "star")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 5)
                                
                                Text(boards.name)
                                    .fontWeight(.regular)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .padding(.leading)
                            .padding(.bottom, 20)
                        }
                         
                    }
                    
                }
                .onAppear{
                    self.loadBoardsService.loadBoards(school: schoolName, motherBoard: motherBoard.name, userId:  Auth.auth().currentUser!.uid)
                }
                
            }
        }
        .padding(.top, 10)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.gray), lineWidth: 1)
        )
        
    }
}

struct BoardMainView_Previews: PreviewProvider {
    static var previews: some View {
        BoardMainView()
    }
}
