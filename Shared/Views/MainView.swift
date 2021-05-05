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
        UITabBar.appearance().backgroundColor = UIColor.white
        
    }
    
    
    var body: some View {
        TabView(selection: $selected) {
            HomeView().tabItem({
                Image(systemName: "house")
            }).tag(0)
            
            BoardMainView().tabItem({
                Image(systemName: "newspaper")
            }).tag(1)
            
            PlazaView().tabItem({
                Image(systemName: "person.3")
            }).tag(2)
            
            TimetableView().tabItem({
                Image(systemName: "calendar")
            }).tag(3)
            
            NotificationsView().tabItem( {
                Image(systemName: "bell")
            }).tag(4)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
