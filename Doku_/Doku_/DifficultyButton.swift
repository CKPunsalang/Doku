//
//  DifficultyButton.swift
//  Doku_
//
//  Created by Calla Punsalang on 10/29/24.
//

import SwiftUI

struct DifficultyButton: View {
    var level: String = "dokuEasy"
    var difficulty: Int = 40
    var action: (DifficultyButton) -> Void = { _ in }
    
    var body: some View {
        Button {
            action(self)
        } label: {
            Image(level)
                .resizable()
                .frame(width: 150, height: 75, alignment: .leading)
        }
    }
}

#Preview {
    DifficultyButton()
}
