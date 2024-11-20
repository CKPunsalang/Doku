//
//  BoardGrid.swift
//  Doku_
//
//  Created by Calla Punsalang on 9/18/24.
//

import SwiftUI
// New imports
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
    @State private var rotation: Double = 0
    @State var difficulty: Int
    @State private var correctnessMessage: String?
    @State private var gameWon: Bool = false
    @State var correct: Bool = false

    
    var body: some View {
        VStack {

        }
        .onAppear {
            generatedBoard = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
            generatedNumbers = [[Bool]](repeating: [Bool](repeating: false, count: 9), count: 9)
            let boards = runDoku(&generatedBoard, &difficulty)
            generatedBoard = boards.puzzle
            checkBoard = boards.complete
            generatedNumbers = presetGenerator(&generatedNumbers)
        }
        
        ZStack {
            BackgroundGrid()
            
            Grid {
                ForEach(0..<generatedBoard.count, id: \.self) { rowIndex in
                    GridRow {
                        ForEach(0..<generatedBoard[rowIndex].count, id: \.self) { colIndex in
                            NumberCircleView(number: $generatedBoard[rowIndex][colIndex], truth: $generatedNumbers[rowIndex][colIndex], correct: $correctness[rowIndex][colIndex])
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
            Divider()
                .frame(height: 5)
                .background(Color.black)
                .opacity(0.75)
            Grid {
                GridRow {
                    // 1
                    if frequencyCheck(&generatedBoard, 1) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuTeal, number: 1)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 1)
                    }
                    
                    //2
                    if frequencyCheck(&generatedBoard, 2) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuYellow, number: 2)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 2)
                    }
                    
                    // 3
                    if frequencyCheck(&generatedBoard, 3) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuPurple, number: 3)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 3)
                    }
                    
                    // 4
                    if frequencyCheck(&generatedBoard, 4) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuRed, number: 4)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 4)
                    }
                    
                    // 5
                    if frequencyCheck(&generatedBoard, 5) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuBlue, number: 5)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 5)
                    }
                    
                    // 6
                    if frequencyCheck(&generatedBoard, 6) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuGreen, number: 6)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 6)
                    }
                    
                    // 7
                    if frequencyCheck(&generatedBoard, 7) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuNavy, number: 7)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 7)
                    }
                    
                    // 8
                    if frequencyCheck(&generatedBoard, 8) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuMaroon, number: 8)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 8)
                    }
                    
                    // 9
                    if frequencyCheck(&generatedBoard, 9) {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuOrange, number: 9)
                    }
                    else {
                        NumberButtonsGrid(selectedNumber: $selectedNumber, buttonColor: Color.dokuDarkGrey, number: 9)
                    }
                }
            }
                .padding()
        }
    }

    
    // Fill a 3x3 block with random numbers
    func fillDiagonal() -> [Int] {
        var used: Set<Int> = []
        var currBlock: [Int] = []
        
        for _ in 0..<9 {
            var currNum = Int.random(in: 1...9)
            while used.contains(currNum) {
                currNum = Int.random(in: 1...9)
            }
            used.insert(currNum)
            currBlock.append(currNum)
        }
        return currBlock
    }

    // Fill the diagonal 3x3 blocks of the Sudoku board
    func fillDiagonalBlocks(_ filledBlock: [Int], _ generatedBoard: inout [[Int]]) {
        var index = 0
        for row0 in 0..<3 {
            for col0 in 0..<3 {
                generatedBoard[row0][col0] = filledBlock[index]
                index += 1
            }
        }
        for row4 in 3..<6 {
            for col4 in 3..<6 {
                generatedBoard[row4][col4] = filledBlock[index]
                index += 1
            }
        }
        for row8 in 6..<9 {
            for col8 in 6..<9 {
                generatedBoard[row8][col8] = filledBlock[index]
                index += 1
            }
        }
    }

    // Sudoku solver algorithm
    func solve(_ bo: inout [[Int]]) -> Bool {
        guard let find = findEmpty(bo) else { return true }
        let (row, col) = find
        
        for i in 1...9 {
            if valid(bo, num: i, pos: (row, col)) {
                bo[row][col] = i
                
                if solve(&bo) {
                    return true
                }
                
                bo[row][col] = 0
            }
        }
        
        return false
    }

    func valid(_ bo: [[Int]], num: Int, pos: (Int, Int)) -> Bool {
        // Check row
        for i in 0..<bo[0].count {
            if bo[pos.0][i] == num && pos.1 != i {
                return false
            }
        }
        
        // Check column
        for i in 0..<bo.count {
            if bo[i][pos.1] == num && pos.0 != i {
                return false
            }
        }
        
        // Check box
        let boxX = pos.1 / 3
        let boxY = pos.0 / 3
        
        for i in (boxY*3)..<(boxY*3 + 3) {
            for j in (boxX*3)..<(boxX*3 + 3) {
                if bo[i][j] == num && (i, j) != pos {
                    return false
                }
            }
        }
        
        return true
    }

    func printBoard(_ bo: [[Int]]) {
        for i in 0..<bo.count {
            if i % 3 == 0 && i != 0 {
                print("- - - - - - - - - - - - - ")
            }
            
            for j in 0..<bo[0].count {
                if j % 3 == 0 && j != 0 {
                    print(" | ", terminator: "")
                }
                
                if j == 8 {
                    print(bo[i][j])
                } else {
                    print("\(bo[i][j]) ", terminator: "")
                }
            }
        }
    }

    func findEmpty(_ bo: [[Int]]) -> (Int, Int)? {
        for i in 0..<bo.count {
            for j in 0..<bo[0].count {
                if bo[i][j] == 0 {
                    return (i, j)
                }
            }
        }
        return nil
    }

    func createPuzzle(_ toSolve: inout [[Int]], _ difficulty: inout Int) {
        let rowToRemove = (0..<difficulty).map { _ in Int.random(in: 0...8) }
        let colToRemove = (0..<difficulty).map { _ in Int.random(in: 0...8) }
        
        for index in 0..<difficulty {
            toSolve[rowToRemove[index]][colToRemove[index]] = 0
        }
    }

    func isSolvable(_ toSolve: inout [[Int]], _ difficulty: inout Int) -> [[Int]] {
        var unsolved = toSolve
        while !solve(&toSolve) {
            createPuzzle(&unsolved, &difficulty)
            var puzzleBoard = isSolvable(&unsolved, &difficulty)
        }
        return unsolved
    }

    @MainActor func runDoku(_ generatedBoard: inout [[Int]], _ difficulty: inout Int) -> (complete: [[Int]], puzzle: [[Int]]) {
        let tempBoard = fillDiagonal() + fillDiagonal() + fillDiagonal()
        fillDiagonalBlocks(tempBoard, &generatedBoard)
        
        _ = solve(&generatedBoard)
        let completedBoard = generatedBoard.map { $0.map { $0 } }
        
        var unsolvedBoard = generatedBoard
        createPuzzle(&unsolvedBoard, &difficulty)
        
        var puzzleBoard = isSolvable(&unsolvedBoard, &difficulty)
        
//        print(completedBoard)
//        print(puzzleBoard)
        
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
    
    struct NumberCircleView: View {
        @Binding var number: Int
        @Binding var truth: Bool
        @Binding var correct: Bool
        
        var body: some View {
            // Preset
            if truth {
                switch number {
                case 1: NumberCircle(color: Color.dokuTeal, number: "1", correct: true)
                case 2: NumberCircle(color: Color.dokuYellow, number: "2", correct: true)
                case 3: NumberCircle(color: Color.dokuPurple, number: "3", correct: true)
                case 4: NumberCircle(color: Color.dokuRed, number: "4", correct: true)
                case 5: NumberCircle(color: Color.dokuBlue, number: "5", correct: true)
                case 6: NumberCircle(color: Color.dokuGreen, number: "6", correct: true)
                case 7: NumberCircle(color: Color.dokuNavy, number: "7", correct: true)
                case 8: NumberCircle(color: Color.dokuMaroon, number: "8", correct: true)
                case 9: NumberCircle(color: Color.dokuOrange, number: "9", correct: true)
                default: NumberCircle(color: Color.dokuGrey, number: " ", correct: true)  // Empty cell
                }
            }
            // User
            else {
                switch number {
                case 1: NumberCircle(color: Color.dokuTeal, fontType: .bold, number: "1", correct: correct)
                case 2: NumberCircle(color: Color.dokuYellow, fontType: .bold, number: "2", correct: correct)
                case 3: NumberCircle(color: Color.dokuPurple, fontType: .bold, number: "3", correct: correct)
                case 4: NumberCircle(color: Color.dokuRed, fontType: .bold, number: "4", correct: correct)
                case 5: NumberCircle(color: Color.dokuBlue, fontType: .bold, number: "5", correct: correct)
                case 6: NumberCircle(color: Color.dokuGreen, fontType: .bold, number: "6", correct: correct)
                case 7: NumberCircle(color: Color.dokuNavy, fontType: .bold, number: "7", correct: correct)
                case 8: NumberCircle(color: Color.dokuMaroon, fontType: .bold, number: "8", correct: correct)
                case 9: NumberCircle(color: Color.dokuOrange, fontType: .bold, number: "9", correct: correct)
                default: NumberCircle(color: Color.dokuGrey, number: " ", correct: correct)  // Empty cell
                }
            }
        }
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
                correctnessMessage = "Wrong"
                correctness[rowIndex][colIndex] = false
            } else if generatedBoard[rowIndex][colIndex] == checkBoard[rowIndex][colIndex] && generatedBoard[rowIndex][colIndex] != 0 {
                correctnessMessage = "Correct"
                correctness[rowIndex][colIndex] = true
            }

            // Check if the game is complete
            if generatedBoard == checkBoard {
                gameWon = true
            }
        }
    
}

#Preview {
    BoardGrid(selectedNumber: 5, difficulty: 10)
        .background() {
            Color.dokuDarkGrey
                .ignoresSafeArea()
        }
}
