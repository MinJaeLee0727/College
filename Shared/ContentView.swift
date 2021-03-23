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
        session.listen()
    }
    
    var body: some View {
        
        Group {
            if (session.session != nil) {
                MainView()
            } else {
                LoginView()
            }
        }.onAppear(perform: listen)
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
#endif
