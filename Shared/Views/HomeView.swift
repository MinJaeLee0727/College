//
//  HomeView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        if (session.user_session == nil) { Text("") }
        
        else {
            NavigationView {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("College")
                            Text(session.user_session?.school ?? "ERROR")
                            //                        Text("University of Waterloo")
                        }
                        
                        Spacer()
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .foregroundColor(.primary)
                                .frame(width: 20, height: 20)
                            
                        })
                        .padding(.trailing)
                        
                        NavigationLink(
                            destination: ProfileView(),
                            label: {
                                Image(systemName: "person")
                                    .resizable()
                                    .foregroundColor(.primary)
                                    .frame(width: 20, height: 20)
                                
                            })
                        
                        //                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        //                        Image(systemName: "person")
                        //                            .foregroundColor(.black)
                        //                    })
                        
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    
                    Spacer()
                }
                .padding([.leading, .trailing])
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
            .ignoresSafeArea()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SessionStore())
//        ContentView()
    }
}

