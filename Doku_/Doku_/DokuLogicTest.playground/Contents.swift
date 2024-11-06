import UIKit
import Foundation

var generatedBoard = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)

/*
print("Base board filled with all 0's")
print(generatedBoard)
print("\n")
 */

func fillDiagonal() -> [Int] {
    var used: [Int] = []
    var currBlock: [Int] = []
    for _ in 0..<9 {
        var currNum = Int.random(in: 1...9)
        while used.contains(currNum) {
            currNum = Int.random(in: 1...9)
        }
        used.append(currNum)
        currBlock.append(currNum)
    }
    return currBlock
}

@MainActor func fillDiagonalBlocks(_ filledBlock: [Int]) {
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

@MainActor func runDoku(board: [[Int]]) -> [[Int]] {
    var filledBlock: [Int] = fillDiagonal()
    filledBlock += fillDiagonal()
    filledBlock += fillDiagonal()
    
    fillDiagonalBlocks(filledBlock)
    
    var solvableBoard = generatedBoard
    _ = solve(&solvableBoard)
    
    createPuzzle(&solvableBoard)
    var unsolvedBoard = isSolvable(&solvableBoard)
    
    print(unsolvedBoard)
    
    return unsolvedBoard
}

/*
var tempBoard: [Int] = []
tempBoard += fillDiagonal()
tempBoard += fillDiagonal()
tempBoard += fillDiagonal()
print("Creating numbers for diagonal")
print(tempBoard)
print("\n")

print("Fill in diagonal blocks")
fillDiagonalBlocks(tempBoard)
print(generatedBoard)
print("\n")
 */

// The sudoku solver algorithm contained within the cell below is from a tutorial by Tech With Tim

// The solve(), valid(), print_board(), find_empty() functions are the only part of this code that are not mine

// Link to the webpage:
// https://www.techwithtim.net/tutorials/python-programming/sudoku-solver-backtracking/part-2

// Link to the YouTube video:
// https://www.youtube.com/watch?v=lK4N8E6uNr4

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

/*
print("Sudoku Board: Diagonals Filled")
printBoard(generatedBoard)
var solvableBoard = generatedBoard
_ = solve(&solvableBoard)
print("___________________")
print("Sudoku Board: Solved Board")
printBoard(solvableBoard)

print("\n")
print("___________________")
print("\n")
 */

func createPuzzle(_ toSolve: inout [[Int]]) {
    let rowToRemove = (0..<40).map { _ in Int.random(in: 0...8) }
    let colToRemove = (0..<40).map { _ in Int.random(in: 0...8) }
    
    for index in 0..<40 {
        toSolve[rowToRemove[index]][colToRemove[index]] = 0
    }
}

@MainActor func isSolvable(_ toSolve: inout [[Int]]) -> [[Int]] {
    let unsolved = toSolve
    if solve(&toSolve) {
        printBoard(unsolved)
        print("___________________")
        printBoard(toSolve)
    } else {
        print("Unsolveable, trying again...")
        toSolve = generatedBoard
        createPuzzle(&toSolve)
        isSolvable(&toSolve)
    }
    return unsolved
}

//var unsolvedBoard = generatedBoard

/*
print(solvableBoard)
print("\n")

createPuzzle(&solvableBoard)
var unsolvedBoard = isSolvable(&solvableBoard)

print("\n")
print(unsolvedBoard)
 */

print("Running Doku")
runDoku(board: generatedBoard)


