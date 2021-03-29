//
//  MainView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI

struct MainView: View {
    @State var selected = 0

    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
    }
    
    
    var body: some View {
        TabView(selection: $selected) {
            HomeView().tabItem({
                Image(systemName: "house")
            }).tag(0)
            
            BoardMainView().tabItem({
                Image(systemName: "newspaper")
            }).tag(1)
            
            AdminView().tabItem({
                Image(systemName: "hand.raised.slash")
            }).tag(4)
            
            NotificationsView().tabItem( {
                Image(systemName: "bell")
            }).tag(3)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
