//
//  PuzzleGeneration.swift
//  Doku_
//
//  Created by Calla Punsalang on 12/7/24.
//
//  The solve(), valid(), printBoard(), and findEmpty() are based on Python code by Tech With Tim
//
//  Link to the webpage:
//  https://www.techwithtim.net/tutorials/python-programming/sudoku-solver-backtracking/part-2
//
//  Link to the YouTube video:
//  https://www.youtube.com/watch?v=lK4N8E6uNr4

import Foundation

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
