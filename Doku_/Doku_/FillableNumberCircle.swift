//
//  FillableNumberCircle.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/24/24.
//

import SwiftUI

struct FillableNumberCircle: View {
    var color = Color.dokuGrey
    @State private var number: String = " "
    var body: some View {
        TextField(" ", text: $number)
            .font(.largeTitle)
            .frame(width: 35, height: 35, alignment: .center)
            .foregroundStyle(.white)
            .background(color)
            .clipShape(Circle())
    }
}

#Preview {
    FillableNumberCircle()
}
