//
//  ContentView.swift
//  Shared
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.user_listen()
        
    }
    
    var body: some View {
        
        Group {
            if (session.user_session_loaded) {
                if (session.user_session != nil) {
                    MainView()
                } else {
                    LoginView()
                }
            } else {
                Image(systemName: "graduationcap.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color("CollegeStudentRepresentColor"))
                    .background(                    Color("LaunchBackgroundColor"))
            }
        }.onAppear(perform: {
            listen()
        })
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
#endif
