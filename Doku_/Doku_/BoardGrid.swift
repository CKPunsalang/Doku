//
//  BoardGrid.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.

import SwiftUI
import UIKit
import Foundation
import AVKit

struct BoardGrid: View {
    @State private var generatedBoard = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    @State private var checkBoard = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    @State private var generatedNumbers = [[Bool]](repeating: [Bool](repeating: false, count: 9), count: 9)
    @State private var correctness = [[Bool]](repeating: [Bool](repeating: false, count: 9), count: 9)
    @State private var selectedCell: [Int]? = [-1, -1]
    
    @State var selectedNumber: Int = -1
    @State var difficulty: Int
    @State private var gameWon: Bool = false
    @State var correct: Bool = false
    var numberedBubbles: Color

    
    var body: some View {
        // VStack so that board is automatically generated upon screen generation 
        VStack {

        }
        .onAppear {
            let boards = runDoku(&generatedBoard, &difficulty)
            // generatedBoard becomes the Sudoku puzzle
            generatedBoard = boards.puzzle
            // checkBoard is the completed puzzle used to check player input on generatedBoard
            checkBoard = boards.complete
            generatedNumbers = presetGenerator(&generatedNumbers)
        }
        
        ZStack {
            BackgroundGrid()
            
            // Grid generation using numbers from generatedBoard
            Grid {
                ForEach(0..<generatedBoard.count, id: \.self) { rowIndex in
                    GridRow {
                        ForEach(0..<generatedBoard[rowIndex].count, id: \.self) { colIndex in
                            // number[Int] holds the current value in that index (whether a generated number or user placed)
                            // truth[Int] holds the correct value for that index
                            // correct[Bool] holds the truth value for whether number[Int] and truth[Int] match
                            // numColor is set on ContentView, if numbered 
                            NumberCircleView(number: $generatedBoard[rowIndex][colIndex],
                                             truth: $generatedNumbers[rowIndex][colIndex],
                                             correct: $correctness[rowIndex][colIndex],
                                             numColor: numberedBubbles)
                                .onTapGesture {
                                    handleCellTap(rowIndex: rowIndex, colIndex: colIndex)
                                    
                                }
                        }
                    }
                }
            }
            if gameWon {
                GifImage("congrats")
                    .frame(width: 400 , height: 200, alignment: .center)

            }
        }
        
        ZStack {
            // Black bar behind buttons
            Divider()
                .frame(height: 5)
                .background(Color.black)
                .opacity(0.75)
            
            // Number buttons row
            Grid {
                GridRow {
                    // Array of Color that holds the correct sequence of colors for the associated number
                    let colors: [Color] = [
                        .dokuTeal, .dokuYellow, .dokuPurple,
                        .dokuRed, .dokuBlue, .dokuGreen,
                        .dokuNavy, .dokuMaroon, .dokuOrange
                    ]
                    
                    ForEach(1...9, id: \ .self) { number in
                        // buttonColor is either the associated color in colors[Color], or .dokuDarkGrey depending on the boolean value from frequencyCheck
                        let buttonColor = frequencyCheck(&generatedBoard, number) ? colors[number - 1] : .dokuDarkGrey
                        NumberButtonsGrid(
                            selectedNumber: $selectedNumber,
                            buttonColor: buttonColor,
                            number: number,
                            numColor: numberedBubbles
                        )
                    }
                }
            }
            .padding()
        }
    }

    @MainActor func runDoku(_ generatedBoard: inout [[Int]], _ difficulty: inout Int) -> (complete: [[Int]], puzzle: [[Int]]) {
        let tempBoard = fillDiagonal() + fillDiagonal() + fillDiagonal()
        fillDiagonalBlocks(tempBoard, &generatedBoard)
        
        _ = solve(&generatedBoard)
        let completedBoard = generatedBoard.map { $0.map { $0 } }
        
        var unsolvedBoard = generatedBoard
        createPuzzle(&unsolvedBoard, &difficulty)
        
        var puzzleBoard = isSolvable(&unsolvedBoard, &difficulty)
        
        return (complete: completedBoard, puzzle: puzzleBoard)
    }
    
    func presetGenerator(_ truthBoard: inout [[Bool]]) -> [[Bool]] {
        for row in 0..<generatedBoard.count {
            for col in 0..<generatedBoard[row].count {
                if generatedBoard[row][col] != 0 {
                    truthBoard[row][col] = true
                }
            }
        }
        return truthBoard
    }
    
    func frequencyCheck(_ puzzleBoard: inout [[Int]], _ wanted: Int) -> Bool {
        var currCount: Int = 0
        var check: Bool = true
        for row in 0..<puzzleBoard.count {
            for col in 0..<puzzleBoard[row].count {
                if puzzleBoard[row][col] == wanted {
                    currCount += 1
                }
            }
        }
        if currCount >= 9 {
            check = false
        }
        return check
    }
    
    func checkPuzzle(_ puzzleBoard: inout [[Int]], _ answersBoard: [[Int]]) -> Bool {
        var correct: Bool = true
        for row in 0..<puzzleBoard.count {
            for col in 0..<puzzleBoard[row].count {
                if puzzleBoard[row][col] != answersBoard[row][col] {
                    puzzleBoard[row][col] = 0
                    correct = false
                }
            }
        }
        if correct {
            print("Puzzle Solved")
        }
        return correct
    }
    
    private func handleCellTap(rowIndex: Int, colIndex: Int) {
            selectedCell = [rowIndex, colIndex]

            if generatedBoard[rowIndex][colIndex] == 0
                && generatedNumbers[rowIndex][colIndex] == false
                && frequencyCheck(&generatedBoard, selectedNumber) {
                generatedBoard[rowIndex][colIndex] = selectedNumber
            } else if generatedBoard[rowIndex][colIndex] != 0 && generatedNumbers[rowIndex][colIndex] == false {
                generatedBoard[rowIndex][colIndex] = 0
            }

            // Check if the selected cell is correct or wrong
            if generatedBoard[rowIndex][colIndex] != checkBoard[rowIndex][colIndex] && generatedBoard[rowIndex][colIndex] != 0 {
                correctness[rowIndex][colIndex] = false
            } else if generatedBoard[rowIndex][colIndex] == checkBoard[rowIndex][colIndex] && generatedBoard[rowIndex][colIndex] != 0 {
                correctness[rowIndex][colIndex] = true
            }

            // Check if the game is complete
            if generatedBoard == checkBoard {
                gameWon = true
            }
        }
    
}

#Preview {
    BoardGrid(selectedNumber: 5, difficulty: 10, numberedBubbles: Color.white)
        .background() {
            Color.dokuDarkGrey
                .ignoresSafeArea()
        }
}
