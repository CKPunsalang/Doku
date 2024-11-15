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
    var body: some View {
        Text(number)
            .font(.largeTitle)
            .fontWeight(fontType)
            .frame(width: 35, height: 35, alignment: .center)
            .foregroundStyle(numColor)
            .background(color)
            .clipShape(Circle())
        /*
            .overlay(
                Circle()
                    .stroke(borderColor, lineWidth: 2.5) // Add a border with desired color and width
                    .padding(2.5)
            )
         */
    }
}

#Preview {
    NumberCircle(borderColor: Color.dokuRed)
}
