# Definitions:
# Direction:    0=up 1=right 2=down 3=left
# Blue Bike:    r1=direction r2=xPosition r3=yPosition
# Yellow Bike:  r4=direction r5=xPosition r6=yPosition
# IO Direction: 1=BlueUp  2=BlueRight  4=BlueDown  8=BlueLeft
# IO Direction: 16=YellowUp 32=YellowRight 64=YellowDown 128=YellowLeft
# IO Direction: 256=Start Game


.resetGame
LUI $156  %r1
ORI $64   %r1     # Load the value 40000 into r1 for beginning of memory wipe

LUI $231   %r2  
ORI $64    %r2    # Load the value 59200 into r2 for end of mem wipe

.memEraseLoop
STOR %r0 %r1      # Set the value in memory at this address to glyph 0
ADDI $1  %r1      # Increment memory count

CMP %r1 %r2       # Leave loop if the entire memory has been set to all 0's
BNE .memEraseLoop


.StartScreen
MOVI $0 %rB

# Always have %rA hold the value of 160.
MOVI $0   %rA
ORI  $160 %rA

# Starting address is x = 9 and y = 45
MOV  %rA %rB
MULI $45 %rB
ADDI $9  %rB
LUI $156 %rC
ORI $64  %rC
ADD %rC  %rB

# Place 1120 into rD for ease of movement.
LUI $4  %rD
ORI $96 %rD

# %rF holds value of .drawBlueSevenBySevenSquare address
LUI  .drawBlueSevenBySevenSquare %rF
MOVI .drawBlueSevenBySevenSquare %rE
OR   %rE %rF

# Draw the letter "T"
JAL %rE %rF
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
ADDI $7 %rB

# %rF holds value of .drawYellowSevenBySevenSquare address
LUI  .drawYellowSevenBySevenSquare %rF
MOVI .drawYellowSevenBySevenSquare %rE
OR   %rE %rF

# Draw the letter "R"
JAL %rE %rF
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
SUBI $7 %rB
JAL %rE %rF
SUBI $7 %rB
JAL %rE %rF
SUBI $7 %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
ADD %rD %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $21 %rB
JAL %rE %rF
SUBI $7 %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $21 %rB

# %rF holds value of .drawBlueSevenBySevenSquare address
LUI  .drawBlueSevenBySevenSquare %rF
MOVI .drawBlueSevenBySevenSquare %rE
OR   %rE %rF

# Draw the letter "O"
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
JAL %rE %rF
ADDI $7 %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
SUBI $7 %rB
JAL %rE %rF
SUBI $7 %rB
JAL %rE %rF
ADDI $28 %rB

# %rF holds value of .drawYellowSevenBySevenSquare address
LUI  .drawYellowSevenBySevenSquare %rF
MOVI .drawYellowSevenBySevenSquare %rE
OR   %rE %rF

# Draw the letter "N"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $21 %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUBI $14 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $7 %rB
JAL %rE %rF

.StartScreenLoop
LUI $234 %r7
ORI $96  %r7   # Store IO/Switch location in the address $60000
LOAD %r8 %r7   # Load the switch value into r8

LUI $1 %r9
CMP %r9 %r8
BNE .StartScreenLoop


.clearScreen
LUI $156  %r1
ORI $64   %r1     # Load the value 40000 into r1 for beginning of memory wipe

LUI $231   %r2  
ORI $64    %r2    # Load the value 59200 into r2 for end of mem wipe

.clearLoop
STOR %r0 %r1      # Set the value in memory at this address to glyph 0
ADDI $1  %r1      # Increment memory count

CMP %r1 %r2       # Leave loop if the entire memory has been set to all 0's
BNE .clearLoop


.StartGame
# Blue Bike Start Registers
MOVI $0   %r1   # Up Direction
MOVI $55  %r2   # x = 55
MOVI $80  %r3   # y = 80

# Yellow Bike Start Registers
MOVI $0   %r4   # Up Direction
MOVI $110 %r5   # x = 110
MOVI $80  %r6   # y = 80

LUI $156  %rA
ORI $64   %rA  # Load 40000 into rA to find in memory
ADD %r2   %rA  # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI  $160 %rB  # Load 160 into rB for memory loc
MUL  %r3  %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds blue pos in memory

MOVI $0   %rA
ORI $160  %rA  # Place 160 into rA for later use.

MOVI $4  %rE 
ADD  %rA %rB
ADD  %rA %rB
STOR %rE %rB  # Load starting vertical path into mem
SUB  %rA %rB
SUB  %rA %rB

# Place bike in starting location
SUB  %rA %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $20 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $21 %rC
STOR %rC %rB

ADD %rA  %rB
MOVI $24 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $23 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $22 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $25 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $26 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $27 %rC
STOR %rC %rB

LUI $156 %rA
ORI $64  %rA   # Load 40000 into rA to find in memory
ADD %r5  %rA   # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI  $160 %rB  # Load 160 into rB for memory loc
MUL  %r6  %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds yellow pos in memory

MOVI $0   %rA
ORI $160  %rA  # Place 160 into rA for later use.

MOVI $29 %rE 
ADD  %rA %rB
ADD  %rA %rB
STOR %rE %rB  # Load starting vertical path into mem
SUB  %rA %rB
SUB  %rA %rB

# Place bike in starting location
SUB  %rA %rB
SUBI $1  %rB
MOVI $44 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $45 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $46 %rC
STOR %rC %rB

ADD %rA  %rB
MOVI $49 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $48 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $47 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $50 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $51 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $52 %rC
STOR %rC %rB


.StartCountDown
LUI $156 %rC
ORI $64  %rC # Place 40000 as a end to the counter in %rC

MOVI $0  %r9
MOVI $0  %rB

# Always have %rA hold the value of 160.
MOVI $0   %rA
ORI  $160 %rA

# Starting address is x = 65 and y = 10
MOV  %rA %rB
MULI $10 %rB
ADDI $65 %rB
ADD  %rC %rB

# Place 320 into rD for ease of movement.
LUI $1  %rD
ORI $64 %rD

.startOfCountDownXY
MOVI $0 %r7
MOVI $0 %r8
LUI $5   %rC
ORI $220 %rC # Place 1500 as a end to the counter in %rC
.countDownLoopY
    MOVI $0 %r8
    .countDownLoopX
        ADDI $1  %r8
        CMP  %r8 %rC
    BNE .countDownLoopX
    ADDI $1  %r7
    CMP  %r7 %rC
BNE .countDownLoopY

ADDI $1 %r9
CMPI $1 %r9
BEQ .DrawNumberThree
CMPI $2 %r9
BEQ .DrawNumberTwo
CMPI $3 %r9
BEQ .DrawNumberOne

# TODO: Erase 3 2 1
LUI  .GameLoop %rF
MOVI .GameLoop %rE
OR   %rE %rF
JUC %rF

# TODO: Draw the actual numbers
.DrawNumberThree
MOVI $53 %rC
STOR %rC %rB
ADDI $2 %rB
BUC .startOfCountDownXY

.DrawNumberTwo
MOVI $53 %rC
STOR %rC %rB
ADDI $2 %rB
BUC .startOfCountDownXY

.DrawNumberOne
MOVI $53 %rC
STOR %rC %rB
ADDI $2 %rB
BUC .startOfCountDownXY



.CounterLoopStart
LUI $156 %rE
ORI $64  %rE # Place 40000 as a end to the counter in %rE
MOVI $0  %rC # Clear %rC

.CounterLoop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $1 %rC # Increment %rC
CMP %rE %rC # Once %rC and %rE are equal continue to game loop
BNE .CounterLoop


.GameLoop



# Jump to end of Code
LUI  .End %rF
MOVI .End %rE
OR   %rE %rF
JUC  %rF


# Space for Methods: Should never be called unless jumped to.
# Return register is always rE. Do not overwrite.
# The top left corner of the square is located in %rB.
# Make sure to return %rB to original value.
# Keep %rA holding the value 0f 160.

.drawBlueSevenBySevenSquare
# %rC holds value of blue square.
MOVI $1 %rC

# Make 7x7 for loop to draw all 49 squares.
MOVI $0 %r1
MOVI $0 %r2
MOVI $7 %r3
.blueSquareYLoop7
    MOVI $0 %r2
    .blueSquareXLoop7
        STOR %rC %rB
        ADDI $1  %rB
        ADDI $1  %r2
        CMP  %r2 %r3
    BNE .blueSquareXLoop7
    SUBI $7  %rB
    ADD  %rA %rB
    ADDI $1  %r1
    CMP  %r1 %r3
BNE .blueSquareYLoop7

# Returning %rB to its original position
MOV  %rA %rC
MULI $7  %rC
SUB  %rC %rB
JUC %rE


.drawYellowSevenBySevenSquare
# %rC holds value of yellow square.
MOVI $2 %rC

# Make 7x7 for loop to draw all 49 squares.
MOVI $0 %r1
MOVI $0 %r2
MOVI $7 %r3
.yellowSquareYLoop7
    MOVI $0 %r2
    .yellowSquareXLoop7
        STOR %rC %rB
        ADDI $1  %rB
        ADDI $1  %r2
        CMP  %r2 %r3
    BNE .yellowSquareXLoop7
    SUBI $7  %rB
    ADD  %rA %rB
    ADDI $1  %r1
    CMP  %r1 %r3
BNE .yellowSquareYLoop7

# Returning %rB to its original position
MOV  %rA %rC
MULI $7  %rC
SUB  %rC %rB
JUC %rE


.drawBlueTwoByTwoSquare
# %rC holds value of blue square.
MOVI $1 %rC

# Make 2x2 for loop to draw all 4 squares.
MOVI $0 %r1
MOVI $0 %r2
MOVI $2 %r3
.blueSquareYLoop2
    MOVI $0 %r2
    .blueSquareXLoop2
        STOR %rC %rB
        ADDI $1  %rB
        ADDI $1  %r2
        CMP  %r2 %r3
    BNE .blueSquareXLoop2
    SUBI $2  %rB
    ADD  %rA %rB
    ADDI $1  %r1
    CMP  %r1 %r3
BNE .blueSquareYLoop2

# Returning %rB to its original position
MOV  %rA %rC
MULI $2  %rC
SUB  %rC %rB
JUC %rE

.drawYellowTwoByTwoSquare
# %rC holds value of blue square.
MOVI $2 %rC

# Make 2x2 for loop to draw all 4 squares.
MOVI $0 %r1
MOVI $0 %r2
MOVI $2 %r3
.blueSquareYLoop2
    MOVI $0 %r2
    .blueSquareXLoop2
        STOR %rC %rB
        ADDI $1  %rB
        ADDI $1  %r2
        CMP  %r2 %r3
    BNE .blueSquareXLoop2
    SUBI $2  %rB
    ADD  %rA %rB
    ADDI $1  %r1
    CMP  %r1 %r3
BNE .blueSquareYLoop2

# Returning %rB to its original position
MOV  %rA %rC
MULI $2  %rC
SUB  %rC %rB
JUC %rE

# End of space for methods.


# End of Code
.End
