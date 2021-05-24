// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// Keyboard is at RAM[24576], while Screen starts at RAM[16384]. 
// This means if we want to fill the whole screen, we need to fill all the RAM
// between 16384 and 24576.
@KBD
D = A
@SCREEN
D = D - A
// MAX is the last pixel needed to fill / empty the entire screen. If i = MAX,
// then the whole screen has been filled / emptied. This value is the difference between
// KBD and SCREEN addresses.
@MAX
M = D

(RESET)
// Reset i to 0
@i
M = 0

(LOOP)
// Check keyboard
@KBD
D = M
@BLACK // if KBD > 0, then it's black
D;JGT
@WHITE // otherwise KBD = 0 and it's white
D;JEQ

// if WHITE, set fill = 0
(WHITE)
@fill
M = 0
@NEXT
0;JMP

// if BLACK, set fill = -1
(BLACK)
@fill
M = -1
@NEXT
0;JMP

(NEXT)
// Check if i = MAX, then reset
@i
D = M
@MAX
D = D - M
@RESET
D;JEQ
// Otherwise, fill the current selected pixel with fill
@SCREEN
D = A
@i
D = D + M
@pixel
M = D
@fill
D = M
@pixel
A = M
M = D
// Then increment i, then go to NEXT to fill the next pixel
@i
M = M + 1
@NEXT
0;JMP