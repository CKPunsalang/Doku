//
//  NumberCircle.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct NumberCircle: View {
    var ColorsDict: [Color: Color] = [Color.dokuMaroon: Color.dokuDarkMaroon,
                                      Color.dokuRed: Color.dokuDarkRed,
                                      Color.dokuOrange: Color.dokuDarkOrange,
                                      Color.dokuYellow: Color.dokuDarkYellow,
                                      Color.dokuGreen: Color.dokuDarkGreen,
                                      Color.dokuTeal: Color.dokuDarkTeal,
                                      Color.dokuBlue: Color.dokuDarkBlue,
                                      Color.dokuNavy: Color.dokuDarkNavy,
                                      Color.dokuPurple: Color.dokuDarkPurple,
                                      Color.dokuGrey: Color.dokuDarkGrey]
    var color = Color.dokuGrey
    //var darkColor = ColorsDict[color]
    var fontType: Font.Weight = .regular
    var number: String = " "
    var numColor = Color.white
    @State var correct: Bool
    @State private var turnCount: Int = 0
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient( colors: [color, Color.dokuDarkRed.opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 35, height: 35, alignment: .center)
                .shadow(color: .dokuDarkGrey.opacity(0.5), radius: 10, x: 5, y: 5)
            
            Text(number)
                .font(.largeTitle)
                .fontWeight(fontType)
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundStyle(numColor)
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
//        ZStack {
//            Text(number)
//                .font(.largeTitle)
//                .fontWeight(fontType)
//                .frame(width: 35, height: 35, alignment: .center)
//                .foregroundStyle(numColor)
//                .background(color)
//                .clipShape(Circle())
//                .onAppear {
//                    turnCount += 1
//                }
//            
//            if !correct && number != " " {
//                Image(systemName: "xmark.seal.fill")
//                    .symbolRenderingMode(.palette)
//                    .foregroundStyle(.red, .dokuGrey)
//                    .frame(width: 35, height: 35, alignment: .center)
//                    .font(.system(size: 30))
//                    .symbolEffect(.rotate, value: turnCount)
//            }
//        }
    }
}

#Preview {
    NumberCircle(number: "1", correct: true)
}

