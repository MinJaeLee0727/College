//
//  Playground2.swift
//  college
//
//  Created by Min Jae Lee on 2021/05/04.
//

import SwiftUI

struct Playground2: View {
    
    @State var outputText: String = ""
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .foregroundColor(.blue)
                        .offset(x: 0)
                        
                    
                    Rectangle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
        }
        .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                                .onEnded { value in
                                    if abs(value.translation.height) < abs(value.translation.width) {
                                        if abs(value.translation.width) > 50.0 {
                                            if value.translation.width < 0 {
                                                self.swipeRightToLeft()
                                            } else if value.translation.width > 0 {
                                                self.swipeLeftToRight()
                                            }
                                        }
                                    }
                                }
        )
    }
    
    func swipeRightToLeft() {
        outputText = "Swiped Right to Left <--"
    }
    
    func swipeLeftToRight() {
        outputText = "Swiped Left to Right -->"
    }
    
}

struct Playground2_Previews: PreviewProvider {
    static var previews: some View {
        Playground2()
    }
}
