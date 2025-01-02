//
//  ContentView.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var testText: String = "This is a test"
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
                    NavigationLink(destination: Settings(testText: testText), label: {
                        Text("Settings")
                    })
                }
                VStack {
                    Text("Test Text: \(testText)")
                }
            }
        }
    }
}

struct SecondView: View {
    @State var selectedDifficulty: Int = 40
    @State private var navigateToThirdView = false
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
                
                
                NavigationLink(destination: ThirdView(selectedDifficulty: 5, numberedBubbles: numberedBubbles), label: {
                    Image("dokuEasy")
                        .resizable()
                        .frame(width: 150, height: 75, alignment: .leading)
                })
                NavigationLink(destination: ThirdView(selectedDifficulty: 40, numberedBubbles: numberedBubbles), label: {
                    Image("dokuMedium")
                        .resizable()
                        .frame(width: 150, height: 75, alignment: .leading)
                })
                NavigationLink(destination: ThirdView(selectedDifficulty: 55, numberedBubbles: numberedBubbles), label: {
                    Image("dokuHard")
                        .resizable()
                        .frame(width: 150, height: 75, alignment: .leading)
                })
                NavigationLink(destination: ThirdView(selectedDifficulty: 70, numberedBubbles: numberedBubbles), label: {
                    Image("dokuExpert")
                        .resizable()
                        .frame(width: 150, height: 75, alignment: .leading)
                })
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

struct Settings: View {
    var testText: String = "Hello, World!"
    var body: some View {
        ZStack {
            Image("dokuSwirl")
                .resizable()
                .frame(width: 1000, height: 1000, alignment: .center)
                .ignoresSafeArea()
        
            VStack {
                Text("Settings Page")
                Text("Test Text: \(testText)")
            }
        }
    }
}

#Preview {
    ContentView()
}
