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
# TODO: Add actual start screen

LUI $234 %r7
ORI $96  %r7   # Store IO/Switch location in the address $60000
LOAD %r8 %r7   # Load the switch value into r8

LUI $1 %r9
CMP %r9 %r8
BNE .StartScreen


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

MOVI $1   %rE  
# TODO: Change what image is displayed:
STOR %rE  %rB  # Load blue square into mem

LUI $156 %rA
ORI $64  %rA   # Load 40000 into rA to find in memory
ADD %r5  %rA   # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI  $160 %rB  # Load 160 into rB for memory loc
MUL  %r6  %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds yellow pos in memory

MOVI $2   %rE 
# TODO: Change what image is displayed:
STOR %rE  %rB  #Load Yellow square into mem


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
JUC %rF

.blueRotateUpToRight
MOVI $1 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateUpToDown
JUC %rF

.blueRotateUpToLeft
MOVI $3 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
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
# TODO: Collision Check
# TODO: Add rotation glyph
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateRightToRight
JUC %rF

.blueRotateRightToDown
MOVI $2 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateRightToLeft
JUC %rF


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
JUC %rF

.blueRotateDownToRight
MOVI $1 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateDownToDown
JUC %rF

.blueRotateDownToLeft
MOVI $3 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
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
# TODO: Collision Check
# TODO: Add rotation glyph
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateLeftToRight
JUC %rF

.blueRotateLeftToDown
MOVI $2 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF

.blueRotateLeftToLeft
JUC %rF


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


# TODO: Change glyphs to be paths
# TODO: Account for collisions by making sure the next block it will move to is not 0.
# TODO: Change glyph to bike not blue square
.move_upB
MOVI $4 %rC
MOVI $0  %rA
ORI $160 %rA
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
SUBI $1  %rB

SUB %rA  %rB
MOVI $20 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $21 %rC
STOR %rC %rB
SUBI $1  %rB

# End Up Movement
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.move_rightB
MOVI $3 %rC
MOVI $0  %rA
ORI $160 %rA
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
MOVI $0  %rA
ORI $160 %rA
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
MOVI $26 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $25 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $27 %rC
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
MOVI $20 %rC
STOR %rC %rB
SUBI $1  %rB
MOVI $19 %rC
STOR %rC %rB
ADDI $2  %rB
MOVI $21 %rC
STOR %rC %rB
SUBI $1 %rB

# End Down Movement
LUI  .blueEnd %rF
MOVI .blueEnd %rE
OR   %rE %rF
JUC  %rF


.move_leftB
MOVI $3 %rC
MOVI $0  %rA
ORI $160 %rA
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


.blueEnd


# Restart Counter and Game Loop
MOVI .CounterLoopStart %rF
JUC %rF


.blueDied


.yellowDied


.End