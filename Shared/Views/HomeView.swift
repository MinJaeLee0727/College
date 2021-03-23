//
//  HomeView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("College")
                        Text("University of Waterloo")
                    }
                        
                    Spacer()
                        
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)

                    })
                    .padding(.trailing)
                    
                    NavigationLink(
                        destination: ProfileView(),
                        label: {
                            Image(systemName: "person")
                                .resizable()
                                .foregroundColor(.black)
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

        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

