//
//  ContentView.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("dokuSwirl")
                    .resizable()
                    .frame(width: 1000, height: 1000, alignment: .center)
                    .ignoresSafeArea()
                VStack {
                    Image("dokuBannerBright")
                        .resizable()
                        .frame(width: 350, height: 150, alignment: .top)
                    NavigationLink(destination: SecondView(), label: {
                        Image("dokuPlay")
                            .resizable()
                            .frame(width: 150, height: 75, alignment: .leading)
                    })
                }
            }
        }
    }
}

struct SecondView: View {
    @State var selectedDifficulty: Int = 40
    @State private var navigateToThirdView = false
    var body: some View {
        VStack {
            ZStack {
                Image("dokuSwirl")
                    .resizable()
                    .frame(width: 1000, height: 1000, alignment: .center)
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: ThirdView(selectedDifficulty: 5), label: {
                        Image("dokuEasy")
                            .resizable()
                            .frame(width: 150, height: 75, alignment: .leading)
                    })
                    NavigationLink(destination: ThirdView(selectedDifficulty: 40), label: {
                        Image("dokuMedium")
                            .resizable()
                            .frame(width: 150, height: 75, alignment: .leading)
                    })
                    NavigationLink(destination: ThirdView(selectedDifficulty: 55), label: {
                        Image("dokuHard")
                            .resizable()
                            .frame(width: 150, height: 75, alignment: .leading)
                    })
                    NavigationLink(destination: ThirdView(selectedDifficulty: 70), label: {
                        Image("dokuExpert")
                            .resizable()
                            .frame(width: 150, height: 75, alignment: .leading)
                    })
                }
            }
        }
    }
}

struct ThirdView: View {
    var selectedDifficulty: Int
    var body: some View {
        VStack {
            BoardGrid(difficulty: selectedDifficulty)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background() {
            Image("dokuSwirl")
                .resizable()
                .frame(width: 1000, height: 1000, alignment: .center)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
