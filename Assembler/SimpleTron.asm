# Definitions:
# Direction:    0=up 1=right 2=down 3=left
# Blue Bike:    r1=direction r2=xPosition r3=yPosition
# Yellow Bike:  r4=direction r5=xPosition r6=yPosition
# IO Direction: 1=BlueUp  2=BlueRight  4=BlueDown  8=BlueLeft
# IO Direction: 16=YellowUp 32=YellowRight 64=YellowDown 128=YellowLeft
# IO Direction: 256=Start/Reset Game


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

CMPI $0 %r1
BEQ .blueUpCases
CMPI $1 %r1
BEQ .blueRightCases
CMPI $2 %r1
BEQ .blueDownCases
CMPI $3 %r1
BEQ .blueLeftCases
BUC .blueBikeMotion


.blueUpCases
ANDI $15 %r8
CMPI $1 %r8
BEQ .rotateUpToUp
CMPI $2 %r8
BEQ .rotateUpToRight
CMPI $4 %r8
BEQ .rotateUpToDown
CMPI $8 %r8
BEQ .rotateUpToLeft
BUC .blueBikeMotion

.rotateUpToUp
BUC .blueBikeMotion

.rotateUpToRight
MOVI $1 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.rotateUpToDown
BUC .blueBikeMotion

.rotateUpToLeft
MOVI $3 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

BUC .blueBikeMotion


.blueRightCases
ANDI $15 %r8
CMPI $1 %r8
BEQ .rotateRightToUp
CMPI $2 %r8
BEQ .rotateRightToRight
CMPI $4 %r8
BEQ .rotateRightToDown
CMPI $8 %r8
BEQ .rotateRightToLeft
BUC .blueBikeMotion

.rotateRightToUp
MOVI $0 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.rotateRightToRight
BUC .blueBikeMotion

.rotateRightToDown
MOVI $2 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.rotateRightToLeft
BUC .blueBikeMotion

BUC .blueBikeMotion

.blueDownCases
#ANDI $15 %r8
#CMPI $1 %r8
#BEQ .rotateDownToUp
#CMPI $2 %r8
#BEQ .rotateDownToRight
#CMPI $4 %r8
#BEQ .rotateDownToDown
#CMPI $8 %r8
#BEQ .rotateDownToLeft
#BUC .blueBikeMotion

#.rotateDownToUp
#BUC .blueBikeMotion

#.rotateDownToRight
#MOVI $1 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
#BUC .blueEnd

#.rotateDownToDown
#BUC .blueBikeMotion

#.rotateDownToLeft
#MOVI $3 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
#BUC .blueEnd


.blueLeftCases
#ANDI $15 %r8
#CMPI $1 %r8
#BEQ .rotateLeftToUp
#CMPI $2 %r8
#BEQ .rotateLeftToRight
#CMPI $4 %r8
#BEQ .rotateLeftToDown
#CMPI $8 %r8
#BEQ .rotateLeftToLeft
#BUC .blueBikeMotion

#.rotateLeftToUp
#MOVI $0 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
#BUC .blueEnd

#.rotateLeftToRight
#BUC .blueBikeMotion

#.rotateLeftToDown
#MOVI $2 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
#BUC .blueEnd

#.rotateLeftToLeft
#BUC .blueBikeMotion


.blueBikeMotion
CMPI $0 %r1
BEQ .move_upB

CMPI $1 %r1
BEQ .move_rightB

CMPI $2 %r1
BEQ .move_downB

CMPI $3 %r1
BEQ .move_leftB


# TODO: Change glyphs to be paths
# TODO: Account for collisions by making sure the next block it will move to is not 0.
# TODO: Change glyph to bike not blue square
.move_upB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
SUBI $1  %r3
MOVI $0  %rA
ORI $160 %rA
SUB %rA  %rB # Move address to new location of bike

STOR %rC %rB # Place bike at new location
BUC .blueEnd


.move_rightB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
ADDI $1  %r2
ADDI $1  %rB # Move address to new location of bike
STOR %rC %rB # Place bike at new location
BUC .blueEnd


.move_downB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Increase Y position
ADDI $1 %r3
MOVI $0  %rA
ORI $160 %rA
ADD %rA  %rB # Move address to new location of bike

STOR %rC %rB # Place bike at new location
BUC .blueEnd


.move_leftB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
SUBI $1  %r2
SUBI $1  %rB # Move address to new location of bike
STOR %rC %rB # Place bike at new location
BUC .blueEnd


.blueEnd


.yellowBikeStart
LUI $156  %rA
ORI $64   %rA  # Load 40000 into rA to find in memory
ADD %r5   %rA  # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI $160  %rB  # Load 160 into rB for memory loc
MUL %r6   %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds yellow pos in memory


.yellowBikeIO
# TODO: Check yellow IO and see if direction has changed.
# TODO: If direction has changed, just change the value of %r4.


.yellowBikeMotion
# TODO: Find a way to tell if the direction has changed to update glyphs correctly.
# Check direction and branch accordingly Yellow bike
CMPI $0 %r4
BEQ .move_upY

CMPI $1 %r4
BEQ .move_rightY

CMPI $2 %r4
BEQ .move_downY

CMPI $3 %r4
BEQ .move_leftY


.move_upY
# TODO: Change glyphs to be paths
MOVI $2 %rC
STOR %rC %rB # Place path block for previous bike location

# TODO: Account for collisions by making sure the next block it will move to is not 0.

# Move bike to new location and update glyph at that new location
SUBI $1  %r6
MOVI $0  %rA
ORI $160 %rA
SUB %rA  %rB # Move address to new lcoation of bike

# TODO: Change glyph to bike not yellow square
STOR %rC %rB # Place bike at new location
BUC .yellowEnd

# TODO Other direction paint squares

.move_rightY
# Increase X position
ADDI $1 %r6
BUC .yellowEnd

.move_downY
# Increase Y position
ADDI $1 %r6
BUC .yellowEnd

.move_leftY
# Decrease X position
SUBI $1 %r6
BUC .yellowEnd


.yellowEnd


# Restart Counter and Game Loop
BUC .CounterLoopStart

.blueDied


.yellowDied


.End
