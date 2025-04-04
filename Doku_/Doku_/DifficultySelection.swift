//
//  DifficultySelection.swift
//  Doku_
//
//  Created by Calla Punsalang on 10/28/24.
//

import SwiftUI

struct DifficultySelection: View {
    @Binding var selectedDifficulty: Int
    var levelSelected = "dokuEasy"
    
    var body: some View {
        VStack {
            DifficultyButton(level: levelSelected, difficulty: selectedDifficulty)
        }
    }
}

#Preview {
    DifficultySelection(selectedDifficulty: .constant(40))
}
