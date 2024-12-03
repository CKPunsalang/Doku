---
layout: page
title: Doku
permalink: /projects/doku/
---

## *[Doku Poster]({{ site.baseurl  }}{% link /content/capstone_poster_final_true.pdf %}){:target="_blank"}*

### **Concept**

I wanted to create a Sudoku app that made Sudoku more enticing to a wider range of audience. Traditional black-and-white Sudoku grids, while functional, can feel overly clinical, uninspiring, and rather boring, especially for those new to the game. The lack of visual variety makes the puzzle seem intimidating or monotonous, rather than inviting or fun. This minimalistic design can unintentionally give the impression that Sudoku is a rigid or purely intellectual exercise, alienating people who prefer visually stimulating or interactive experiences.

Doku adds color, animations, and moving elements that sparks a sense of playfullness and accessibility, especially those who may have an aversion to numbers. These design elements help to transform the traditional and monotonous game of Sudoku into something more lively where players can focus on patterns and the joy of colors while still engaging in healthy mental challenge and stimulation.

My goal was to allow this amazing brain game to be more accessible to: 
- The elderly, who can focus on just the colors and their patterns
- Those who hate math or have dyscalculia
- Children who would benefit from the mental workout that Sudoku provides

Doku does not change the game of Sudoku, it simply gives it a new look and adds some features that helps those newer to the game. For those new to Sudoku here are the basic rules:

1. You can fill each spot on the 9x9 grid with any number 1-9 (the 9x9 grid is broken up into 9 smaller grids of 3x3)
1. The same number cannot be repeated in the same **row**
1. The same number cannot be repeated in the same **column**
1. The same number cannot be repeated in the same **3x3 sqaure**

### **Implementation**

While Doku is written entirely in Swift and SwiftUI now, it did not start off that way.

Before this project, I had never coded in Swift or SwiftUI so I knew learning that would be imperative. However, that did not mean that the first and only thing to do was to learn this new language. I knew other coding languages.

So, I wrote the puzzle generating algorithm for Doku in Python on Google Colab while using LinkedIn Learning courses to teach myself Swift/SwiftUI.

My algorithm for puzzle creation is as follows:
1. Create an empty sudoku board (a 9x9 grid).
1. Fill the diagonal 3x3 squares with random numbers 1-9 (following the standard rules of having no repeating numbers within the 3x3 square).
1. Use a Sudoku solver to "solve" the partially filled Sudoku board.
1. Randomly remove a set amount of numbers from the "solved" board.
1. From this created puzzle, use the same Sudoku solver to see if the created puzzle is solvable.
1. If the generated puzzle is solvable, then the algorithm is finished. If not, then repeat Step 4 again until a correct puzzle is created.

Once I had completed my LinkedIn Learning courses and perfected my Python algorithm, it was time to convert the latter into the former. Of course, as it was my first time coding in Swift/SwiftUI, there were some hiccups, but with determination (and a lot of research), I now had my Python algorithm in an Xcode project, written in Swift.

From here, I created the UI elements needed to actually play a game of Sudoku. Below are the various stages of Doku in development:

<img src="/Doku/images/doku_python.png" alt="Python generated Sudoku puzzle" width="292" height="579">

This is the output of the Python generatated Sudoku puzzles. The top grid of numbers is the generated puzzle, and the bottom is the solved version.


<img src="/Doku/images/doku_stage1.png" alt="Doku Stage 1" width="292" height="579">

At this stage, there is still no backend for Doku as the puzzle algorithm is still in Python. However, I wanted to get a feel for using Swift and SwiftUI so I made a base grid for where and how I would want the puzzle to generate. 

<img src="/Doku/images/doku_stage2.png" alt="Doku Stage 2" width="292" height="579">

This stage is similar to the previous one. I'm continuing to add and play around more with SwiftUI and various UI elements, there is still no puzzle generating algorithm.


<img src="/Doku/images/doku_stage3.png" alt="Doku Stage 3" width="292" height="579">

The UI has stayed the same at this stage, but there is now a backend working. On the grid there are some numbers that are filled out, still no puzzle generating algorithm but I wanted to test out how the grid would look with numbers filled in. Filling in random numbers also allowed me to play with the spacing of the numbers.


<img src="/Doku/images/doku_stage4.png" alt="Doku Stage 4" width="292" height="579">

There is now a number line of buttons at the bottom of the screen. When clicked, the corresponding number would show in Xcode's debugging terminal, but not on the actual screen. There was also a major overhaul of the grid UI, now following the more bubble-y and playful nature that Doku is intended to have. Although not shown, at this point the Python algorithm had been convereted to Swift and I was working on debugging it through Swift Playgrounds.


<img src="/Doku/images/doku_stage5.png" alt="Doku Stage 5" width="292" height="579">

The puzzle generation is now working and generates puzzles in their correct place and corresponding colors. The number line works too and allows players to fill in their guesses on the puzzle board (the bolded numbers are numbers placed by the player). The puzzles are not generated automatically at this point, as the Doku logo needs to be pressed to generate one.


<img src="/Doku/images/doku_stage6.png" alt="Doku Stage 6" width="292" height="579">

This is where Doku is currently at. There is a working number line at the bottom for players to fill in their guesses and the puzzle is automatically generated with the page loading. 

### **Features**
