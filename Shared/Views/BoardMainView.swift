//
//  BoardView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI

struct BoardMainView: View {
    
    @EnvironmentObject var session: SessionStore
//
//    func getMotherBoards() {
//        let firestoreUserId = storeRoot.collection("Universities").document(session.session!.school).collection("motherBoards")
//
//        firestoreUserId.getDocument {
//            (document, error) in
//            if let dict = document?.data() {
//                guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
//
//                onSuccess(decodedUser)
//            }
//        }
//    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                topBoardCard(user: self.session.session)
                
                
                motherBoardCard()
                motherBoardCard()
            }
            .padding()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(true)
        }

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
    @State var collapse = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Mother Board")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .lineLimit(1)
                    
                    if collapse {
                        Text("Subtitle")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {self.collapse.toggle()}) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .font(Font.body.weight(.semibold))
                }
            }
            .padding(.all, 16)
            
            if !collapse {
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "star")
                                .foregroundColor(.secondary)
                        }
                        .padding(.trailing, 5)
                        
                        Text("Board")
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "star")
                                .foregroundColor(.secondary)
                        }
                        .padding(.trailing, 5)
                        
                        Text("Board")
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "star")
                                .foregroundColor(.secondary)
                        }
                        .padding(.trailing, 5)
                        
                        Text("Board")
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 20)
                    
                }
                .padding(.top, 10)
            }
        }
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
