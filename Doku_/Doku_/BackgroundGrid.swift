//
//  BackgroundGrid.swift
//  DokuOptimizedLogic
//
//  Created by Calla Punsalang on 10/27/24.
//

import SwiftUI

struct BackgroundGrid: View {
    var body: some View {
        ZStack {
            VStack {
                Divider()
                    .frame(width: 375, height: 4)
                    .background(.black)
                    .opacity(0.75)
                    .padding(59)
                Divider()
                    .frame(width: 375, height: 4)
                    .background(.black)
                    .opacity(0.75)
                    .padding(59)
            }
            HStack {
                Divider()
                    .frame(width: 4, height: 375)
                    .background(.black)
                    .opacity(0.75)
                    .padding(59)
                Divider()
                    .frame(width: 4, height: 375)
                    .background(.black)
                    .opacity(0.75)
                    .padding(59)
            }
        }
    }
}

#Preview {
    BackgroundGrid()
}
