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
        VStack(alignment: .center, spacing: 20) {
            NavigationView {
                VStack {
                    Text("Navigation View")
                    NavigationLink(destination: Text("Showwing Widget")) {
                        HStack {
                            Text("Navigation Link")
                        }
                        .frame(width: 300, height: 200)
                        .border(Color.blue)
                    }
                    .border(Color.red)
                    Spacer()
                }
                .border(Color.yellow)
            }
            
            Text(outputText)
                .font(.title)
                .fontWeight(.bold)
            
            Text("My Green Oval")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.title)
                .frame(width: 300, height: 200)
                .background(
                    Ellipse()
                        .fill(Color.green)
                )
            Button(action: {
                outputText = "Button tapped"
            }) {
                Text("Button to Tap")
            }
            
            Text("Just some words...")
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
    }}

struct Playground2_Previews: PreviewProvider {
    static var previews: some View {
        Playground2()
    }
}
