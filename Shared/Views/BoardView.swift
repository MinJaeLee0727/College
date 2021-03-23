//
//  BoardView.swift
//  college
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI

struct BoardView: View {
    var body: some View {
        ZStack {
            ScrollView {
                motherBoard()
            }
        }
    }
}

struct motherBoard: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
            
            
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
