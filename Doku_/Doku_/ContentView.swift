//
//  ContentView.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            ShopView()
                .tabItem {
                    Label("Shop", systemImage: "cart")
                }
                .tag(0)
            PlayView()
                .tabItem() {
                    Label("Play", systemImage: "bubbles.and.sparkles")
                }
                .tag(1)
            LeaderBoardView()
                .tabItem() {
                    Label("Leaderboard", systemImage: "chart.bar.fill")
                }
                .tag(2)
        }
    }
}

struct PlayView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("dokuSwirl")
                    .resizable()
                    .frame(width: 1000, height: 1000, alignment: .center)
                    .ignoresSafeArea()
                VStack {
                    Image("dokuBanner")
                        .resizable()
                        .frame(width: 350, height: 150, alignment: .top)
                    NavigationLink(destination: DifficultySelect(), label: {
                        Capsule()
                            .fill(Color.dokuRed)
                            .frame(width: 150, height: 75)
                            .overlay(
                                Text("PLAY")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                    })
                    NavigationLink(destination: SettingsView(), label: {
                        Capsule()
                            .fill(Color.dokuBlue)
                            .frame(width: 150, height: 75)
                            .overlay {
                                Text("SETTINGS")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                    })
                }
            }
        }
    }
}

struct DifficultySelect: View {
    @State var selectedDifficulty: Int = 40
    @State private var showNumbers = true
    private var numberedBubbles: Color {
        showNumbers ? Color.white : Color.clear
    }
    var body: some View {
        ZStack {
            Image("dokuSwirl")
                .resizable()
                .frame(width: 1000, height: 1000, alignment: .center)
                .ignoresSafeArea()
            VStack {
                Toggle(showNumbers ? "Numbers On" : "Numbers Off", isOn: $showNumbers)
                    .toggleStyle(.button)
                    .tint(.mint)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .top)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack {
                    HStack{
                        Button(action: {
                            selectedDifficulty = 5
                        }) {
                            Text("Easy")
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.white)
                                .background(self.selectedDifficulty == 5 ? Color.dokuGreen : Color.dokuGrey)
                                .clipShape(Capsule())
                        }
                        Button(action: {
                            selectedDifficulty = 40
                        }) {
                            Text("Medium")
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.white)
                                .background(self.selectedDifficulty == 40 ? Color.dokuYellow : Color.dokuGrey)
                                .clipShape(Capsule())
                        }
                    }
                    HStack{
                        Button(action: {
                            selectedDifficulty = 55
                        }) {
                            Text("Hard")
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.white)
                                .background(self.selectedDifficulty == 55 ? Color.dokuOrange : Color.dokuGrey)
                                .clipShape(Capsule())
                        }
                        Button(action: {
                            selectedDifficulty = 70
                        }) {
                            Text("Expert")
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.white)
                                .background(self.selectedDifficulty == 70 ? Color.dokuRed : Color.dokuGrey)
                                .clipShape(Capsule())
                        }
                    }
                }
                NavigationLink(destination: ThirdView(selectedDifficulty: selectedDifficulty, numberedBubbles: numberedBubbles), label: {
                    Image("dokuPlay")
                        .resizable()
                        .frame(width: 300, height: 125, alignment: .leading)
                })
                
//                NavigationLink(destination: ThirdView(selectedDifficulty: 5, numberedBubbles: numberedBubbles), label: {
//                    Image("dokuEasy")
//                        .resizable()
//                        .frame(width: 150, height: 75, alignment: .leading)
//                })
//                NavigationLink(destination: ThirdView(selectedDifficulty: 40, numberedBubbles: numberedBubbles), label: {
//                    Image("dokuMedium")
//                        .resizable()
//                        .frame(width: 150, height: 75, alignment: .leading)
//                })
//                NavigationLink(destination: ThirdView(selectedDifficulty: 55, numberedBubbles: numberedBubbles), label: {
//                    Image("dokuHard")
//                        .resizable()
//                        .frame(width: 150, height: 75, alignment: .leading)
//                })
//                NavigationLink(destination: ThirdView(selectedDifficulty: 70, numberedBubbles: numberedBubbles), label: {
//                    Image("dokuExpert")
//                        .resizable()
//                        .frame(width: 150, height: 75, alignment: .leading)
//                })
            }
        }
    }
}

struct ThirdView: View {
    var selectedDifficulty: Int
    var numberedBubbles: Color
    var body: some View {
        VStack {
            BoardGrid(difficulty: selectedDifficulty, numberedBubbles: numberedBubbles)
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
