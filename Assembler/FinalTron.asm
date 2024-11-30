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
LUI $7   %rC
ORI $208 %rC # Place 2000 as a end to the counter in %rC
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
BEQ .DrawFirstNumber
CMPI $2 %r9
BEQ .DrawSecondNumber
CMPI $3 %r9
BEQ .DrawThirdNumber

# Erase the counter numbers
ADD %rD %rB
LUI $156  %r1
ORI $64   %r1     # Load the value 40000 into r1 for beginning of memory wipe

.counterEraseLoop
STOR %r0 %r1      # Set the value in memory at this address to glyph 0
ADDI $1  %r1      # Increment memory count

CMP %r1 %rB       # Leave loop if the entire memory has been set to all 0's
BNE .counterEraseLoop

# Return values of blue bike as they were used.
# Should only be called after the countdown.
MOVI $0   %r1   # Up Direction
MOVI $55  %r2   # x = 55
MOVI $80  %r3   # y = 80

LUI  .GameLoop %rF
MOVI .GameLoop %rE
OR   %rE %rF
JUC %rF

.DrawFirstNumber
LUI  .DrawNumberThree %rF
MOVI .DrawNumberThree %rE
OR   %rE %rF
JUC  %rF

.DrawSecondNumber
LUI  .DrawNumberTwo %rF
MOVI .DrawNumberTwo %rE
OR   %rE %rF
JUC  %rF

.DrawThirdNumber
LUI  .DrawNumberOne %rF
MOVI .DrawNumberOne %rE
OR   %rE %rF
JUC  %rF


.DrawNumberThree
# %rF holds value of .drawWhiteTwoByTwoSquare address
LUI  .drawWhiteTwoByTwoSquare %rF
MOVI .drawWhiteTwoByTwoSquare %rE
OR   %rE %rF

ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
ADDI $16 %rB

# Return to countdown
LUI  .startOfCountDownXY %rF
MOVI .startOfCountDownXY %rE
OR   %rE %rF
JUC  %rF

.DrawNumberTwo
# %rF holds value of .drawWhiteTwoByTwoSquare address
LUI  .drawWhiteTwoByTwoSquare %rF
MOVI .drawWhiteTwoByTwoSquare %rE
OR   %rE %rF

JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $6 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
ADDI $16 %rB

# Return to countdown
LUI  .startOfCountDownXY %rF
MOVI .startOfCountDownXY %rE
OR   %rE %rF
JUC  %rF


.DrawNumberOne
# %rF holds value of .drawWhiteTwoByTwoSquare address
LUI  .drawWhiteTwoByTwoSquare %rF
MOVI .drawWhiteTwoByTwoSquare %rE
OR   %rE %rF

JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
ADDI $4 %rB
JAL %rE %rF

# Return to countdown
LUI  .startOfCountDownXY %rF
MOVI .startOfCountDownXY %rE
OR   %rE %rF
JUC  %rF


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


.blueBikeStart
LUI $156  %rA
ORI $64   %rA  # Load 40000 into rA to find in memory
ADD %r2   %rA  # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI $160  %rB  # Load 160 into rB for memory loc
MUL %r3   %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds blue pos in memory
MOVI $0   %rA
ORI $160  %rA  # Place 160 into rA for later use.


.blueBikeIO
LUI $234 %r7
ORI $96  %r7   # Store IO/Switch location in the address $60000
LOAD %r8 %r7   # Load the switch value into r8


LUI  .blueUpCases %rF
MOVI .blueUpCases %rE
OR   %rE %rF
CMPI $0 %r1
JEQ  %rF

LUI  .blueRightCases %rF
MOVI .blueRightCases %rE
OR   %rE %rF
CMPI $1 %r1
JEQ  %rF

LUI  .blueDownCases %rF
MOVI .blueDownCases %rE
OR   %rE %rF
CMPI $2 %r1
JEQ  %rF

LUI  .blueLeftCases %rF
MOVI .blueLeftCases %rE
OR   %rE %rF
CMPI $3 %r1
JEQ  %rF

LUI  .blueBikeMotion %rF
MOVI .blueBikeMotion %rE
OR   %rE %rF
JUC  %rF


.blueUpCases
LUI  .blueBikeMotion %rF
MOVI .blueBikeMotion %rE
OR   %rE %rF

ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateUpToUp
CMPI $2 %r8
BEQ .blueRotateUpToRight
CMPI $4 %r8
BEQ .blueRotateUpToDown
CMPI $8 %r8
BEQ .blueRotateUpToLeft
JUC %rF

.blueRotateUpToUp
.blueRotateUpToDown
JUC %rF

.blueRotateUpToRight
MOVI $1 %r1
ADDI $2 %r2

# Rotate Glyph
MOVI $8 %rC
STOR %rC %rB
MOVI $0  %rC
SUB  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
MOVI $4  %rC
ADDI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
ADDI $1  %rB
MOVI $16 %rC
STOR %rC %rB
ADDI $1  %rB
LOAD %rE %rB # Check if this block is already taken and die if so
CMPI $0  %rE
JNE  %rF
MOVI $17 %rC
STOR %rC %rB
ADDI $1  %rB
LOAD %rE %rB # Check if this block is already taken and die if so
CMPI $0  %rE
JNE  %rF
MOVI $18 %rC
STOR %rC %rB

SUB  %rA %rB
LOAD %rE %rB # Check if this block is already taken and die if so
CMPI $0  %rE
JNE  %rF
MOVI $15 %rC
STOR %rC %rB
SUBI $1  %rB
LOAD %rE %rB # Check if this block is already taken and die if so
CMPI $0  %rE
JNE  %rF
MOVI $14 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $13 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $10 %rC
STOR %rC %rB
ADDI $1  %rB
LOAD %rE %rB # Check if this block is already taken and die if so
CMPI $0  %rE
JNE  %rF
MOVI $11 %rC
STOR %rC %rB
ADDI $1  %rB
LOAD %rE %rB # Check if this block is already taken and die if so
CMPI $0  %rE
JNE  %rF
MOVI $12 %rC
STOR %rC %rB

# Check if after turning the bike went off screen.
LUI  .blueDied %rF
MOVI .blueDied %rE
OR   %rE %rF

SUBI $1  %rA
CMP  %r2 %rA
JGE  %rF
ADDI $1  %rA

# Jump to End
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateUpToLeft
MOVI $3 %r1
SUBI $2 %r2

# Rotate Glyph
MOVI $6 %rC
STOR %rC %rB
MOVI $0  %rC
SUB  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
MOVI $4  %rC
SUBI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
SUBI $1  %rB
MOVI $18 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $17 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $16 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $13 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $14 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $15 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $12 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $11 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $10 %rC
STOR %rC %rB

# Jump to End
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.blueRightCases
LUI  .blueBikeMotion %rF
MOVI .blueBikeMotion %rE
OR   %rE %rF

ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateRightToUp
CMPI $2 %r8
BEQ .blueRotateRightToRight
CMPI $4 %r8
BEQ .blueRotateRightToDown
CMPI $8 %r8
BEQ .blueRotateRightToLeft
JUC %rF

.blueRotateRightToUp
MOVI $0 %r1
SUBI $2 %r3

# Rotate Glyph
MOVI $7  %rC
STOR %rC %rB
MOVI $0  %rC
ADDI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
MOVI $3  %rC
SUB  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
SUB  %rA %rB
MOVI $25 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $26 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $27 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $24 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $23 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $22 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $20 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $21 %rC
STOR %rC %rB

LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateRightToRight
.blueRotateRightToLeft
JUC %rF

.blueRotateRightToDown
MOVI $2 %r1
ADDI $2 %r3

# Rotate Glyph
MOVI $6  %rC
STOR %rC %rB
MOVI $0  %rC
ADDI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
MOVI $3  %rC
ADD  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
ADD  %rA %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $20 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $21 %rC
STOR %rC %rB

ADD  %rA %rB
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

LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.blueDownCases
LUI  .blueBikeMotion %rF
MOVI .blueBikeMotion %rE
OR   %rE %rF

ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateDownToUp
CMPI $2 %r8
BEQ .blueRotateDownToRight
CMPI $4 %r8
BEQ .blueRotateDownToDown
CMPI $8 %r8
BEQ .blueRotateDownToLeft
JUC %rF

.blueRotateDownToUp
.blueRotateDownToDown
JUC %rF

.blueRotateDownToRight
MOVI $1 %r1
ADDI $2 %r2

# Rotate Glyph
MOVI $9 %rC
STOR %rC %rB
MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
MOVI $4  %rC
ADDI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
ADDI $1  %rB
MOVI $10 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $11 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $12 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $15 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $14 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $13 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $16 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $17 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $18 %rC
STOR %rC %rB

LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateDownToLeft
MOVI $3 %r1
SUBI $2 %r2

# Rotate Glyph
MOVI $7 %rC
STOR %rC %rB
MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
MOVI $4  %rC
SUBI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
SUBI $1  %rB
MOVI $12 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $11 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $10 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $13 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $14 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $15 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $18 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $17 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $16 %rC
STOR %rC %rB

LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.blueLeftCases
LUI  .blueBikeMotion %rF
MOVI .blueBikeMotion %rE
OR   %rE %rF

ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateLeftToUp
CMPI $2 %r8
BEQ .blueRotateLeftToRight
CMPI $4 %r8
BEQ .blueRotateLeftToDown
CMPI $8 %r8
BEQ .blueRotateLeftToLeft
JUC %rF

.blueRotateLeftToUp
MOVI $0 %r1
SUBI $2 %r3

# Rotate Glyph
MOVI $9  %rC
STOR %rC %rB
MOVI $0  %rC
SUBI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
MOVI $3  %rC
SUB  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
SUB  %rA %rB
MOVI $27 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $26 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $25 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $22 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $23 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $24 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $21 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $20 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB

LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateLeftToRight
.blueRotateLeftToLeft
JUC %rF

.blueRotateLeftToDown
MOVI $2 %r1
ADDI $2 %r3

# Rotate Glyph
MOVI $8  %rC
STOR %rC %rB
MOVI $0  %rC
SUBI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
MOVI $3  %rC
ADD  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
ADD  %rA %rB
MOVI $21 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $20 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $22 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $23 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $24 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $27 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $26 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $25 %rC
STOR %rC %rB

LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.blueBikeMotion
LUI  .move_upB %rF
MOVI .move_upB %rE
OR   %rE %rF
CMPI $0 %r1
JEQ  %rF

LUI  .move_rightB %rF
MOVI .move_rightB %rE
OR   %rE %rF
CMPI $1 %r1
JEQ  %rF

LUI  .move_downB %rF
MOVI .move_downB %rE
OR   %rE %rF
CMPI $2 %r1
JEQ  %rF

LUI  .move_leftB %rF
MOVI .move_leftB %rE
OR   %rE %rF
CMPI $3 %r1
JEQ  %rF


# TODO: Account for collisions by making sure the next block it will move to is not 0.
.move_upB
MOVI $4 %rC
ADD %rA  %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0 %rC
SUBI $1 %rB
STOR %rC %rB # Remove Bike Corner
ADDI $2 %rB
STOR %rC %rB # Remove Bike Corner
SUBI $1 %rB  # restore to middle of bike

# Move bike to new location and update glyph at that new location
SUBI $1  %r3

SUB %rA  %rB
MOVI $26 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $25 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $27 %rC
STOR %rC %rB
SUBI $1 %rB

SUB %rA  %rB
MOVI $23 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $22 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $24 %rC
STOR %rC %rB
SUBI $1 %rB

SUB %rA  %rB
MOVI $20 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $21 %rC
STOR %rC %rB
SUBI $1 %rB

# End Up Movement
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.move_rightB
MOVI $3 %rC
SUBI $1 %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB # Remove Bike Corner
SUB  %rA %rB
SUB  %rA %rB
STOR %rC %rB # Remove Bike Corner
ADD  %rA %rB # restore to middle of bike

# Move bike to new location and update glyph at that new location
ADDI $1  %r2

ADDI $1  %rB
MOVI $13 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $10 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $16 %rC
STOR %rC %rB
SUB  %rA %rB

ADDI $1  %rB
MOVI $14 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $11 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $17 %rC
STOR %rC %rB
SUB  %rA %rB

ADDI $1  %rB
MOVI $15 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $12 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $18 %rC
STOR %rC %rB
SUB  %rA %rB

# End Right Movement
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.move_downB
MOVI $4 %rC
SUB %rA  %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0 %rC
SUBI $1 %rB
STOR %rC %rB # Remove Bike Corner
ADDI $2 %rB
STOR %rC %rB # Remove Bike Corner
SUBI $1 %rB  # restore to middle of bike

# Move bike to new location and update glyph at that new location
ADDI $1  %r3

ADD %rA  %rB
MOVI $20 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $21 %rC
STOR %rC %rB
SUBI $1 %rB

ADD %rA  %rB
MOVI $23 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $22 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $24 %rC
STOR %rC %rB
SUBI $1 %rB

ADD %rA  %rB
MOVI $26 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $25 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $27 %rC
STOR %rC %rB
SUBI $1 %rB

# End Down Movement
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.move_leftB
MOVI $3 %rC
ADDI $1 %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB # Remove Bike Corner
SUB  %rA %rB
SUB  %rA %rB
STOR %rC %rB # Remove Bike Corner
ADD  %rA %rB # restore to middle of bike

# Move bike to new location and update glyph at that new location
SUBI $1  %r2

SUBI $1  %rB
MOVI $15 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $12 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $18 %rC
STOR %rC %rB
SUB  %rA %rB

SUBI $1  %rB
MOVI $14 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $11 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $17 %rC
STOR %rC %rB
SUB  %rA %rB

SUBI $1  %rB
MOVI $13 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $10 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $16 %rC
STOR %rC %rB
SUB  %rA %rB

# End Left Movement
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.blueEnd


.yellowBikeStart
LUI $156  %rA
ORI $64   %rA  # Load 40000 into rA to find in memory
ADD %r5   %rA  # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI $160  %rB  # Load 160 into rB for memory loc
MUL %r6   %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds yellow pos in memory
MOVI $0   %rA
ORI $160  %rA  # Load 160 into rA for later use


.yellowBikeIO
LUI $234 %r7
ORI $96  %r7   # Store IO/Switch location in the address $60000
LOAD %r8 %r7   # Load the switch value into r8


LUI  .yellowUpCases %rF
MOVI .yellowUpCases %rE
OR   %rE %rF
CMPI $0 %r4
JEQ  %rF

LUI  .yellowRightCases %rF
MOVI .yellowRightCases %rE
OR   %rE %rF
CMPI $1 %r4
JEQ  %rF

LUI  .yellowDownCases %rF
MOVI .yellowDownCases %rE
OR   %rE %rF
CMPI $2 %r4
JEQ  %rF

LUI  .yellowLeftCases %rF
MOVI .yellowLeftCases %rE
OR   %rE %rF
CMPI $3 %r4
JEQ  %rF

LUI  .yellowBikeMotion %rF
MOVI .yellowBikeMotion %rE
OR   %rE %rF
JUC  %rF


.yellowUpCases
LUI  .yellowBikeMotion %rF
MOVI .yellowBikeMotion %rE
OR   %rE %rF

MOVI $0 %r7
ORI  $240 %r7
AND  %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateUpToUp
CMPI $32 %r8
BEQ .yellowRotateUpToRight
CMPI $64 %r8
BEQ .yellowRotateUpToDown
MOVI $0 %r7
ORI  $128 %r7
CMP  %r7 %r8
BEQ .yellowRotateUpToLeft
JUC %rF

.yellowRotateUpToUp
.yellowRotateUpToDown
JUC %rF

.yellowRotateUpToRight
MOVI $1 %r4
ADDI $2 %r5

# Rotate Glyph
MOVI $33 %rC
STOR %rC %rB
MOVI $0  %rC
SUB  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
MOVI $29 %rC
ADDI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
ADDI $1  %rB
MOVI $41 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $42 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $43 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $40 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $39 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $38 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $35 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $36 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $37 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF

JUC %rF

.yellowRotateUpToLeft
MOVI $3 %r4
SUBI $2 %r5

# Rotate Glyph
MOVI $31 %rC
STOR %rC %rB
MOVI $0  %rC
SUB  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
MOVI $29 %rC
SUBI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
SUBI $1  %rB
MOVI $43 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $42 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $41 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $38 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $39 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $40 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $37 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $36 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $35 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF


.yellowRightCases
LUI  .yellowBikeMotion %rF
MOVI .yellowBikeMotion %rE
OR   %rE %rF

MOVI $0 %r7
ORI  $240 %r7
AND  %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateRightToUp
CMPI $32 %r8
BEQ .yellowRotateRightToRight
CMPI $64 %r8
BEQ .yellowRotateRightToDown
MOVI $0 %r7
ORI  $128 %r7
CMP  %r7 %r8
BEQ .yellowRotateRightToLeft
JUC %rF

.yellowRotateRightToUp
MOVI $0 %r4
SUBI $2 %r6

# Rotate Glyph
MOVI $32 %rC
STOR %rC %rB
MOVI $0  %rC
ADDI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
MOVI $28 %rC
SUB  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
SUB  %rA %rB
MOVI $50 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $51 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $52 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $49 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $48 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $47 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $44 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $45 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $46 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF

.yellowRotateRightToRight
.yellowRotateRightToLeft
JUC %rF

.yellowRotateRightToDown
MOVI $2 %r4
ADDI $2 %r6

# Rotate Glyph
MOVI $31 %rC
STOR %rC %rB
MOVI $0  %rC
ADDI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
MOVI $28 %rC
ADD  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
ADD  %rA %rB
MOVI $44 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $45 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $46 %rC
STOR %rC %rB

ADD  %rA %rB
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

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF

.yellowDownCases
LUI  .yellowBikeMotion %rF
MOVI .yellowBikeMotion %rE
OR   %rE %rF

MOVI $0 %r7
ORI  $240 %r7
AND  %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateDownToUp
CMPI $32 %r8
BEQ .yellowRotateDownToRight
CMPI $64 %r8
BEQ .yellowRotateDownToDown
MOVI $0 %r7
ORI  $128 %r7
CMP  %r7 %r8
BEQ .yellowRotateDownToLeft
JUC %rF

.yellowRotateDownToUp
.yellowRotateDownToDown
JUC %rF

.yellowRotateDownToRight
MOVI $1 %r4
ADDI $2 %r5

# Rotate Glyph
MOVI $34 %rC
STOR %rC %rB
MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB
SUBI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
MOVI $29 %rC
ADDI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
ADDI $1  %rB
MOVI $35 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $36 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $37 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $40 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $39 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $38 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $41 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $42 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $43 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF

.yellowRotateDownToLeft
MOVI $3 %r4
SUBI $2 %r5

# Rotate Glyph
MOVI $32 %rC
STOR %rC %rB
MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
MOVI $29 %rC
SUBI $1  %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently bottom middle of og)
SUBI $1  %rB
MOVI $37 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $36 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $35 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $38 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $39 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $40 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $43 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $42 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $41 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF


.yellowLeftCases
LUI  .yellowBikeMotion %rF
MOVI .yellowBikeMotion %rE
OR   %rE %rF

MOVI $0 %r7
ORI  $240 %r7
AND  %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateLeftToUp
CMPI $32 %r8
BEQ .yellowRotateLeftToRight
CMPI $64 %r8
BEQ .yellowRotateLeftToDown
MOVI $0 %r7
ORI  $128 %r7
CMP  %r7 %r8
BEQ .yellowRotateLeftToLeft
JUC %rF

.yellowRotateLeftToUp
MOVI $0 %r4
SUBI $2 %r6

# Rotate Glyph
MOVI $34 %rC
STOR %rC %rB
MOVI $0  %rC
SUBI $1  %rB
STOR %rC %rB
ADD  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
MOVI $28 %rC
SUB  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
SUB  %rA %rB
MOVI $52 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $51 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $50 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $47 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $48 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $49 %rC
STOR %rC %rB

SUB  %rA %rB
MOVI $46 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $45 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $44 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF

.yellowRotateLeftToRight
.yellowRotateLeftToLeft
JUC %rF

.yellowRotateLeftToDown
MOVI $2 %r4
ADDI $2 %r6

# Rotate Glyph
MOVI $33 %rC
STOR %rC %rB
MOVI $0  %rC
SUBI $1  %rB
STOR %rC %rB
SUB  %rA %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
ADDI $1  %rB
STOR %rC %rB
MOVI $28 %rC
ADD  %rA %rB
STOR %rC %rB

# TODO: Perform Collision Check (%rB is currently left middle of og)
ADD  %rA %rB
MOVI $46 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $45 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $44 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $47 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $48 %rC
STOR %rC %rB
ADDI $1  %rB
MOVI $49 %rC
STOR %rC %rB

ADD  %rA %rB
MOVI $52 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $51 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $50 %rC
STOR %rC %rB

# Jump to End
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF


.yellowBikeMotion
LUI  .move_upY %rF
MOVI .move_upY %rE
OR   %rE %rF
CMPI $0 %r4
JEQ  %rF

LUI  .move_rightY %rF
MOVI .move_rightY %rE
OR   %rE %rF
CMPI $1 %r4
JEQ  %rF

LUI  .move_downY %rF
MOVI .move_downY %rE
OR   %rE %rF
CMPI $2 %r4
JEQ  %rF

LUI  .move_leftY %rF
MOVI .move_leftY %rE
OR   %rE %rF
CMPI $3 %r4
JEQ  %rF


# TODO: Account for collisions by making sure the next block it will move to is not 0.
.move_upY
MOVI $29 %rC
ADD %rA  %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0  %rC
SUBI $1  %rB
STOR %rC %rB # Remove Bike Corner
ADDI $2  %rB
STOR %rC %rB # Remove Bike Corner
SUBI $1  %rB # restore to middle of bike

# Move bike to new location and update glyph at that new location
SUBI $1  %r6

SUB %rA  %rB
MOVI $51 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $50 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $52 %rC
STOR %rC %rB
SUBI $1  %rB

SUB %rA  %rB
MOVI $48 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $47 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $49 %rC
STOR %rC %rB
SUBI $1  %rB

SUB %rA  %rB
MOVI $45 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $44 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $46 %rC
STOR %rC %rB
SUBI $1  %rB

# End Up Movement
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF


.move_rightY
MOVI $28 %rC
SUBI $1  %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB # Remove Bike Corner
SUB  %rA %rB
SUB  %rA %rB
STOR %rC %rB # Remove Bike Corner
ADD  %rA %rB # restore to middle of bike

# Move bike to new location and update glyph at that new location
ADDI $1  %r5

ADDI $1  %rB
MOVI $38 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $35 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $41 %rC
STOR %rC %rB
SUB  %rA %rB

ADDI $1  %rB
MOVI $39 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $36 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $42 %rC
STOR %rC %rB
SUB  %rA %rB

ADDI $1  %rB
MOVI $40 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $37 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $43 %rC
STOR %rC %rB
SUB  %rA %rB

# End Right Movement
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF


.move_downY
MOVI $29 %rC
SUB %rA  %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0 %rC
SUBI $1 %rB
STOR %rC %rB # Remove Bike Corner
ADDI $2 %rB
STOR %rC %rB # Remove Bike Corner
SUBI $1 %rB  # restore to middle of bike

# Move bike to new location and update glyph at that new location
ADDI $1  %r6

ADD %rA  %rB
MOVI $45 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $44 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $46 %rC
STOR %rC %rB
SUBI $1 %rB

ADD %rA  %rB
MOVI $48 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $47 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $49 %rC
STOR %rC %rB
SUBI $1 %rB

ADD %rA  %rB
MOVI $51 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $50 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $52 %rC
STOR %rC %rB
SUBI $1 %rB

# End Down Movement
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF


.move_leftY
MOVI $28 %rC
ADDI $1 %rB
STOR %rC %rB # Place path block for previous bike location

MOVI $0  %rC
ADD  %rA %rB
STOR %rC %rB # Remove Bike Corner
SUB  %rA %rB
SUB  %rA %rB
STOR %rC %rB # Remove Bike Corner
ADD  %rA %rB # restore to middle of bike

# Move bike to new location and update glyph at that new location
SUBI $1  %r5

SUBI $1  %rB
MOVI $40 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $37 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $43 %rC
STOR %rC %rB
SUB  %rA %rB

SUBI $1  %rB
MOVI $39 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $36 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $42 %rC
STOR %rC %rB
SUB  %rA %rB

SUBI $1  %rB
MOVI $38 %rC
STOR %rC %rB
SUB  %rA %rB
MOVI $35 %rC
STOR %rC %rB
ADD  %rA %rB
ADD  %rA %rB
MOVI $41 %rC
STOR %rC %rB
SUB  %rA %rB

# End Left Movement
LUI  .yellowEnd %rF
MOVI .yellowEnd %rE
OR   %rE %rF
JUC  %rF

.yellowEnd


# Restart Counter and Game Loop
LUI  .CounterLoopStart %rF
MOVI .CounterLoopStart %rE
OR   %rE %rF
JUC  %rF



.blueDied
# Display the message "Yellow Wins"
MOVI $0 %rB

# Always have %rA hold the value of 160.
MOVI $0   %rA
ORI  $160 %rA

# Starting address is x = 30 and y = 5
MOV  %rA %rB
MULI $5  %rB
ADDI $30 %rB
LUI $156 %rC # Start at 40000
ORI $64  %rC
ADD %rC  %rB

# Place 320 into rD for ease of movement.
LUI $1  %rD
ORI $64 %rD

# %rF holds value of .drawYellowTwoByTwoSquare address
LUI  .drawYellowTwoByTwoSquare %rF
MOVI .drawYellowTwoByTwoSquare %rE
OR   %rE %rF

# Draw the letter "Y"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $2 %rB
JAL %rE %rF
ADD %rD %rB
ADDI $2 %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
ADDI $4 %rB

# Draw the letter "E"
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $6 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $4 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $4 %rB

# Draw the letter "L"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $4 %rB

# Draw the letter "L"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $4 %rB

# Draw the letter "O"
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
ADDI $8 %rB

# Draw the letter "W"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
ADDI $8 %rB

# Draw the letter "W"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
ADDI $4 %rB

# Draw the letter "I"
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
ADDI $4 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $4 %rB

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
ADDI $6 %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUBI $4 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
ADDI $12 %rB

# Draw the letter "S"
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF

# Jump to end of Code
LUI  .End %rF
MOVI .End %rE
OR   %rE %rF
JUC  %rF


.yellowDied
# Display the message "Blue Wins"
MOVI $0 %rB

# Always have %rA hold the value of 160.
MOVI $0   %rA
ORI  $160 %rA

# Starting address is x = 40 and y = 5
MOV  %rA %rB
MULI $5  %rB
ADDI $40 %rB
LUI $156 %rC # Start at 40000
ORI $64  %rC
ADD %rC  %rB

# Place 320 into rD for ease of movement.
LUI $1  %rD
ORI $64 %rD

# %rF holds value of .drawBlueTwoByTwoSquare address
LUI  .drawBlueTwoByTwoSquare %rF
MOVI .drawBlueTwoByTwoSquare %rE
OR   %rE %rF

# Draw the letter "B"
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $6 %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $6 %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $6 %rB

# Draw the letter "L"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $4 %rB

# Draw the letter "U"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
ADDI $4 %rB

# Draw the letter "E"
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $6 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $4 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $8 %rB

# Draw the letter "W"
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
SUB %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
ADDI $4 %rB

# Draw the letter "I"
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
ADDI $4 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
SUB %rD %rB
ADDI $4 %rB

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
ADDI $6 %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUB %rD %rB
JAL %rE %rF
SUBI $4 %rB
ADD %rD %rB
JAL %rE %rF
ADD %rD %rB
ADDI $2 %rB
JAL %rE %rF
SUB %rD %rB
SUB %rD %rB
ADDI $12 %rB

# Draw the letter "S"
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
ADDI $2 %rB
JAL %rE %rF
ADDI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
ADD %rD %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF
SUBI $2 %rB
JAL %rE %rF

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
.yellowSquareYLoop2
    MOVI $0 %r2
    .yellowSquareXLoop2
        STOR %rC %rB
        ADDI $1  %rB
        ADDI $1  %r2
        CMP  %r2 %r3
    BNE .yellowSquareXLoop2
    SUBI $2  %rB
    ADD  %rA %rB
    ADDI $1  %r1
    CMP  %r1 %r3
BNE .yellowSquareYLoop2

# Returning %rB to its original position
MOV  %rA %rC
MULI $2  %rC
SUB  %rC %rB
JUC %rE

.drawWhiteTwoByTwoSquare
# %rC holds value of blue square.
MOVI $53 %rC

# Make 2x2 for loop to draw all 4 squares.
MOVI $0 %r1
MOVI $0 %r2
MOVI $2 %r3
.whiteSquareYLoop2
    MOVI $0 %r2
    .whiteSquareXLoop2
        STOR %rC %rB
        ADDI $1  %rB
        ADDI $1  %r2
        CMP  %r2 %r3
    BNE .whiteSquareXLoop2
    SUBI $2  %rB
    ADD  %rA %rB
    ADDI $1  %r1
    CMP  %r1 %r3
BNE .whiteSquareYLoop2

# Returning %rB to its original position
MOV  %rA %rC
MULI $2  %rC
SUB  %rC %rB
JUC %rE

# End of space for methods.


# End of Code
.End
