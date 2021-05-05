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
    
    @StateObject var loadMotherBoardsService = LoadBoardService()
    
    @State var isConnected = NetworkService.shared.isConnected
    
    var body: some View {
        if (self.session.user_session != nil) {
            
            if isConnected {
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        topBoardCard(user: self.session.user_session)
                        
                        ForEach(self.loadMotherBoardsService.motherBoards, id:\.name) {
                            (motherBoards) in
                            
                            motherBoardCard(schoolName: self.session.user_session?.school ?? "ERROR", boards: motherBoards.boards, motherBoard: motherBoards.name, subtitle: motherBoards.subtitle)
                                .padding(.bottom, 5)
                        }
                        
                    }
                    .onAppear {
                        self.loadMotherBoardsService.loadMotherBoards(university: self.session.user_session?.school ?? "ERROR", userId:  Auth.auth().currentUser?.uid ?? "ERROR")
                    }
                    .padding()
                    .navigationTitle(" ")
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationBarHidden(true)
                }
                .ignoresSafeArea()
            } else {
                Text("Please connect to the Internet")
            }
 
        } else { Text("ERROR") }
    }
}

struct topBoardCard: View {
    var user: UserModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(
                destination: MyPostsView(),
                label: {
                    HStack {
                        Image(systemName: "doc.fill")
                            .foregroundColor(Color("CollegeStudentRepresentColor"))
                            .padding(.trailing, 5)
                        
                        Text("My Posts")
                            .fontWeight(.regular)
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
                    .fontWeight(.regular)
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
                    .fontWeight(.regular)
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
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 20)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                        .padding(.trailing, 5)
                    
                    Text("Hot Posts")
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.bottom, 20)
            })
            
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
    
    @State var schoolName: String
    @State var boards: [String]
    @State var motherBoard: String
    @State var subtitle: String
    @State var collapse = false
    
    func likeBoard() {
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(motherBoard)")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    if collapse {
                        Text("\(subtitle)")
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
                    
                    ForEach(boards, id:\.self) {
                        (board) in
                        
                        NavigationLink(destination: BoardView(schoolName: schoolName, motherBoard: motherBoard, board: board)) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "bookmark")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 5)
                                
                                Text(board)
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
