//
//  LoadingView.swift
//  college
//
//  Created by Min Jae Lee on 2021/03/02.
//

import SwiftUI

struct LoadingView: View {
//    let color = Color(UIColor(named: "CollegeStudentRepresentColor")!)

    @State var animation = false
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.8)
            
            ProgressView()
                .frame(width: 40, height: 40)
                .progressViewStyle(CircularProgressViewStyle(tint:.gray))
                .scaleEffect(3)
        }
//        VStack(alignment: .center) {
//            Circle()
//                .trim(from: 0, to: 0.7)
//                .stroke(color, lineWidth: 8)
//                .frame(width: 75, height: 75)
//                .rotationEffect(.init(degrees: animation ? 360 : 0))
//                .padding(50)
//
//        }
//        .background(Color.white)
//        .cornerRadius(20)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
//        .onAppear(perform: {
//            withAnimation(Animation.linear(duration: 2)) {
//                animation.toggle()
//            }
//        })
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
