//
//  NumberButton.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct NumberButton: View {
    var color = Color.dokuTeal
    var buttonNumber: Int = 1
    var action: (NumberButton) -> Void = { _ in }
    var selectedNumberButton: Int? = -1
    var numColor: Color = .white
    var body: some View {
        Button {
            action(self)
        } label: {
            Text(String(buttonNumber))
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundStyle(numColor)
                .background(color)
                .clipShape(Circle())
        }
    }
}

#Preview {
    NumberButton()
}
