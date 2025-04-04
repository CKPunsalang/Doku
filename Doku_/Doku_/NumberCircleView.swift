//
//  NumberCircleView.swift
//  Doku_
//
//  Created by Calla Punsalang on 1/2/25.
//

import SwiftUI

struct NumberCircleView: View {
    @Binding var number: Int
    @Binding var truth: Bool
    @Binding var correct: Bool
    var numColor: Color
    
    var body: some View {
        // Preset
        if truth {
            switch number {
            case 1: NumberCircle(color: Color.dokuTeal, number: "1", numColor: numColor, correct: true)
            case 2: NumberCircle(color: Color.dokuYellow, number: "2", numColor: numColor, correct: true)
            case 3: NumberCircle(color: Color.dokuPurple, number: "3", numColor: numColor, correct: true)
            case 4: NumberCircle(color: Color.dokuRed, number: "4", numColor: numColor, correct: true)
            case 5: NumberCircle(color: Color.dokuBlue, number: "5", numColor: numColor, correct: true)
            case 6: NumberCircle(color: Color.dokuGreen, number: "6", numColor: numColor, correct: true)
            case 7: NumberCircle(color: Color.dokuNavy, number: "7", numColor: numColor, correct: true)
            case 8: NumberCircle(color: Color.dokuMaroon, number: "8", numColor: numColor, correct: true)
            case 9: NumberCircle(color: Color.dokuOrange, number: "9", numColor: numColor, correct: true)
            default: NumberCircle(color: Color.dokuGrey, number: " ", numColor: numColor, correct: true)  // Empty cell
            }
        }
        // User
        else {
            switch number {
            case 1: NumberCircle(color: Color.dokuTeal, fontType: .bold, number: "1", numColor: numColor, correct: correct)
            case 2: NumberCircle(color: Color.dokuYellow, fontType: .bold, number: "2", numColor: numColor, correct: correct)
            case 3: NumberCircle(color: Color.dokuPurple, fontType: .bold, number: "3", numColor: numColor, correct: correct)
            case 4: NumberCircle(color: Color.dokuRed, fontType: .bold, number: "4", numColor: numColor, correct: correct)
            case 5: NumberCircle(color: Color.dokuBlue, fontType: .bold, number: "5", numColor: numColor, correct: correct)
            case 6: NumberCircle(color: Color.dokuGreen, fontType: .bold, number: "6", numColor: numColor, correct: correct)
            case 7: NumberCircle(color: Color.dokuNavy, fontType: .bold, number: "7", numColor: numColor, correct: correct)
            case 8: NumberCircle(color: Color.dokuMaroon, fontType: .bold, number: "8", numColor: numColor, correct: correct)
            case 9: NumberCircle(color: Color.dokuOrange, fontType: .bold, number: "9", numColor: numColor, correct: correct)
            default: NumberCircle(color: Color.dokuGrey, number: " ", correct: correct)  // Empty cell
            }
        }
    }
}

#Preview {
    NumberCircleView(number: .constant(0), truth: .constant(false), correct: .constant(false), numColor: Color.dokuGrey)
}
