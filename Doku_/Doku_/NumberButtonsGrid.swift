//
//  NumberButtonsGrid.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct NumberButtonsGrid: View {
    @Binding var selectedNumber: Int
    var buttonColor = Color.dokuGrey
    var number = 0
    var numColor: Color = Color.white
    var body: some View {
        NumberButton(color: buttonColor, buttonNumber: number, action: buttonWasPressed, numColor: numColor)
            .scaleEffect(selectedNumber == number ? 1.3 : 1.0) // Slightly larger if selected
            .animation(.easeInOut(duration: 0.2), value: selectedNumber)
    }
    
    
    func buttonWasPressed(button: NumberButton) {
        //print(button.buttonNumber)
        selectedNumber = button.buttonNumber
    }
}

#Preview {
    @Previewable @State var selectedNumber: Int = 11
    NumberButtonsGrid(selectedNumber: $selectedNumber)
        .background(.black)
}
