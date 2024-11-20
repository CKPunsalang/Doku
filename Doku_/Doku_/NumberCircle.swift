//
//  NumberCircle.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct NumberCircle: View {
    var color = Color.dokuGrey
    var borderColor = Color.dokuGrey
    var fontType: Font.Weight = .regular
    var number: String = " "
    var numColor = Color.white
    @State var correct: Bool
    @State private var turnCount: Int = 0
    var body: some View {
        ZStack {
            Text(number)
                .font(.largeTitle)
                .fontWeight(fontType)
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundStyle(numColor)
                .background(color)
                .clipShape(Circle())
                .onAppear {
                    turnCount += 1
                }
            
            if !correct && number != " " {
                Image(systemName: "xmark.seal.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.red, .dokuGrey)
                    .frame(width: 35, height: 35, alignment: .center)
                    .font(.system(size: 30))
                    .symbolEffect(.rotate, value: turnCount)
            }
        }
    }
}



#Preview {
    NumberCircle(borderColor: Color.dokuRed, number: "1", correct: false)
}

