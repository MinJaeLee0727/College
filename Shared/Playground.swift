//
//  Playground.swift
//  college
//
//  Created by Min Jae Lee on 2021/04/29.
//

import SwiftUI

struct Playground: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("College")
                        Text("University of Waterloo")
                    }
                    
                    Spacer()
                    
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .foregroundColor(.primary)
//                            .frame(width: 20, height: 20)
//
//                    })
//                    .padding(.trailing)
                    
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
                
                ScrollView(.horizontal) {
                    HStack{
                        WhatsNextCard()
                        TodoCard()
                    }
                }
                
                Spacer()
            }
            .padding([.leading, .trailing])
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}

struct TodoCard: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.square")
                    .foregroundColor(.blue)
                    .font(.system(size: 33, weight: .regular))
                
                VStack {
                    Text("Todos")
                        .font(.title3)
                    
                }
                
                Spacer()
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            .padding(.top)
            .frame(height: 40)

            Divider()
                        
            VStack {
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "square")
                            .foregroundColor(.primary)
                    })
                    
                    Text("136 HW")
                    
                    Spacer()
                }
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding()
        .frame(width: 250, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color(.lightGray), lineWidth: 1)
        )
        
    }
}

struct WhatsNextCard: View {
    
    @State var CourseData: [String:String] = ["09:00" : "CS 135", "12:00" : "MATH 136", "14:00" : "ECON 101", "15:45" : "ENGL 119"]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "sun.max.fill")
                    .renderingMode(.original)
                    .font(.system(size: 33, weight: .regular))
                
                VStack {
                    Text("Good Morning, Chris")
                        .font(.title3)
                    
                }
                
                Spacer()
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            .padding(.top)
            .frame(height: 40)
            
            Divider()
            
            VStack {
                ForEach(CourseData.sorted(by: <), id: \.key) {
                    time, course in
                                        
                    HStack(spacing: 10) {
                        Text(time)
                            .font(.body)
                        
                        Text(course)
                            .font(.body)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color(.lightGray), lineWidth: 1)
        )
    }
}

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}
