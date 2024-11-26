# Definitions:
# Direction: 0=up 1=right 2=down 3=left
# Blue Bike: r1=direction r2=xPosition r3=yPosition
# Yellow Bike: r4=direction r5=xPosition r6=yPosition
# IO Direction: 1=BlueUp 2=BlueRight 4=BlueDown 8=BlueLeft
# IO Direction: 16=YellowUp 32=YellowRight 64=YellowDown 128=YellowLeft
# IO Direction: 256=Start/Reset Game


.resetGame
LUI $156 %r1
ORI $64 %r1 # Load the value 40000 into r1 for beginning of memory wipe

LUI $231 %r2
ORI $64 %r2 # Load the value 59200 into r2 for end of mem wipe

.memEraseLoop
STOR %r0 %r1 # Set the value in memory at this address to glyph 0
ADDI $1 %r1 # Increment memory count

CMP %r1 %r2 # Leave loop if the entire memory has been set to all 0's
BNE .memEraseLoop


.StartScreen
# TODO: Add actual start screen

LUI $234 %r7
ORI $96 %r7 # Store IO/Switch location in the address $60000
LOAD %r8 %r7 # Load the switch value into r8

LUI $1 %r9
CMP %r9 %r8
BNE .StartScreen


.StartGame
# Blue Bike Start Registers
MOVI $0 %r1 # Up Direction
MOVI $55 %r2 # x = 55
MOVI $80 %r3 # y = 80

# Yellow Bike Start Registers
MOVI $0 %r4 # Up Direction
MOVI $110 %r5 # x = 110
MOVI $80 %r6 # y = 80

LUI $156 %rA
ORI $64 %rA # Load 40000 into rA to find in memory
ADD %r2 %rA # Shift rA to 40000 + xposition

MOVI $0 %rB
ORI $160 %rB # Load 160 into rB for memory loc
MUL %r3 %rB # 160 * %r3 = y position in memory

ADD %rA %rB # rB holds blue pos in memory

MOVI $1 %rE
# TODO: Change what image is displayed:
STOR %rE %rB # Load blue square into mem

LUI $156 %rA
ORI $64 %rA # Load 40000 into rA to find in memory
ADD %r5 %rA # Shift rA to 40000 + xposition

MOVI $0 %rB
ORI $160 %rB # Load 160 into rB for memory loc
MUL %r6 %rB # 160 * %r3 = y position in memory

ADD %rA %rB # rB holds yellow pos in memory

MOVI $2 %rE
# TODO: Change what image is displayed:
STOR %rE %rB #Load Yellow square into mem


.CounterLoopStart
LUI $156 %rE
ORI $64 %rE # Place 40000 as a end to the counter in %rE
MOVI $0 %rC # Clear %rC

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
LUI $156 %rA
ORI $64 %rA # Load 40000 into rA to find in memory
ADD %r2 %rA # Shift rA to 40000 + xposition

MOVI $0 %rB
ORI $160 %rB # Load 160 into rB for memory loc
MUL %r3 %rB # 160 * %r3 = y position in memory

ADD %rA %rB # rB holds blue pos in memory


.blueBikeIO
LUI $234 %r7
ORI $96 %r7 # Store IO/Switch location in the address $60000
LOAD %r8 %r7 # Load the switch value into r8

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
BEQ .blueRotateUpToUp
CMPI $2 %r8
BEQ .blueRotateUpToRight
CMPI $4 %r8
BEQ .blueRotateUpToDown
CMPI $8 %r8
BEQ .blueRotateUpToLeft
BUC .blueBikeMotion

.blueRotateUpToUp
BUC .blueBikeMotion

.blueRotateUpToRight
MOVI $1 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.blueRotateUpToDown
BUC .blueBikeMotion

.blueRotateUpToLeft
MOVI $3 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

BUC .blueBikeMotion


.blueRightCases
ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateRightToUp
CMPI $2 %r8
BEQ .blueRotateRightToRight
CMPI $4 %r8
BEQ .blueRotateRightToDown
CMPI $8 %r8
BEQ .blueRotateRightToLeft
BUC .blueBikeMotion

.blueRotateRightToUp
MOVI $0 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.blueRotateRightToRight
BUC .blueBikeMotion

.blueRotateRightToDown
MOVI $2 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.blueRotateRightToLeft
BUC .blueBikeMotion

BUC .blueBikeMotion


.blueDownCases
ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateDownToUp
CMPI $2 %r8
BEQ .blueRotateDownToRight
CMPI $4 %r8
BEQ .blueRotateDownToDown
CMPI $8 %r8
BEQ .blueRotateDownToLeft
BUC .blueBikeMotion

.blueRotateDownToUp
BUC .blueBikeMotion

.blueRotateDownToRight
MOVI $1 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.blueRotateDownToDown
BUC .blueBikeMotion

.blueRotateDownToLeft
MOVI $3 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

BUC .blueBikeMotion


.blueLeftCases
ANDI $15 %r8
CMPI $1 %r8
BEQ .blueRotateLeftToUp
CMPI $2 %r8
BEQ .blueRotateLeftToRight
CMPI $4 %r8
BEQ .blueRotateLeftToDown
CMPI $8 %r8
BEQ .blueRotateLeftToLeft
BUC .blueBikeMotion

.blueRotateLeftToUp
MOVI $0 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.blueRotateLeftToRight
BUC .blueBikeMotion

.blueRotateLeftToDown
MOVI $2 %r1
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .blueEnd

.blueRotateLeftToLeft
BUC .blueBikeMotion

BUC .blueBikeMotion


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
SUBI $1 %r3
MOVI $0 %rA
ORI $160 %rA
SUB %rA %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .blueEnd


.move_rightB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
ADDI $1 %r2
ADDI $1 %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .blueEnd


.move_downB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Increase Y position
ADDI $1 %r3
MOVI $0 %rA
ORI $160 %rA
ADD %rA %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .blueEnd


.move_leftB
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
SUBI $1 %r2
SUBI $1 %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .blueEnd


.blueEnd


.yellowBikeStart
LUI $156 %rA
ORI $64 %rA # Load 40000 into rA to find in memory
ADD %r5 %rA # Shift rA to 40000 + xposition

MOVI $0 %rB
ORI $160 %rB # Load 160 into rB for memory loc
MUL %r6 %rB # 160 * %r3 = y position in memory

ADD %rA %rB # rB holds yellow pos in memory


.yellowBikeIO
LUI $234 %r7
ORI $96 %r7 # Store IO/Switch location in the address $60000
LOAD %r8 %r7 # Load the switch value into r8

CMPI $0 %r4
BEQ .yellowUpCases
CMPI $1 %r4
BEQ .yellowRightCases
CMPI $2 %r4
BEQ .yellowDownCases
CMPI $3 %r4
BEQ .yellowLeftCases
BUC .yellowBikeMotion


.yellowUpCases
MOVI $0 %r7
ORI $240 %r7
AND %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateUpToUp
CMPI $32 %r8
BEQ .yellowRotateUpToRight
CMPI $64 %r8
BEQ .yellowRotateUpToDown
MOVI $0 %r7
ORI $128 %r7
CMP %r7 %r8
BEQ .yellowRotateUpToLeft
BUC .yellowBikeMotion

.yellowRotateUpToUp
BUC .yellowBikeMotion

.yellowRotateUpToRight
MOVI $1 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

.yellowRotateUpToDown
BUC .yellowBikeMotion

.yellowRotateUpToLeft
MOVI $3 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

BUC .yellowBikeMotion


.yellowRightCases
MOVI $0 %r7
ORI $240 %r7
AND %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateRightToUp
CMPI $32 %r8
BEQ .yellowRotateRightToRight
CMPI $64 %r8
BEQ .yellowRotateRightToDown
MOVI $0 %r7
ORI $128 %r7
CMP %r7 %r8
BEQ .yellowRotateRightToLeft
BUC .yellowBikeMotion

.yellowRotateRightToUp
MOVI $0 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

.yellowRotateRightToRight
BUC .yellowBikeMotion

.yellowRotateRightToDown
MOVI $2 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

.yellowRotateRightToLeft
BUC .yellowBikeMotion

BUC .yellowBikeMotion


.yellowDownCases
MOVI $0 %r7
ORI $240 %r7
AND %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateDownToUp
CMPI $32 %r8
BEQ .yellowRotateDownToRight
CMPI $64 %r8
BEQ .yellowRotateDownToDown
MOVI $0 %r7
ORI $128 %r7
CMP %r7 %r8
BEQ .yellowRotateDownToLeft
BUC .yellowBikeMotion

.yellowRotateDownToUp
BUC .yellowBikeMotion

.yellowRotateDownToRight
MOVI $1 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

.yellowRotateDownToDown
BUC .yellowBikeMotion

.yellowRotateDownToLeft
MOVI $3 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

BUC .yellowBikeMotion


.yellowLeftCases
MOVI $0 %r7
ORI $240 %r7
AND %r7 %r8
CMPI $16 %r8
BEQ .yellowRotateLeftToUp
CMPI $32 %r8
BEQ .yellowRotateLeftToRight
CMPI $64 %r8
BEQ .yellowRotateLeftToDown
MOVI $0 %r7
ORI $128 %r7
CMP %r7 %r8
BEQ .yellowRotateLeftToLeft
BUC .yellowBikeMotion

.yellowRotateLeftToUp
MOVI $0 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

.yellowRotateLeftToRight
BUC .yellowBikeMotion

.yellowRotateLeftToDown
MOVI $2 %r4
# TODO: Collision Check
# TODO: Add rotation glyph
BUC .yellowEnd

.yellowRotateLeftToLeft
BUC .yellowBikeMotion

BUC .yellowBikeMotion


.yellowBikeMotion
CMPI $0 %r4
BEQ .move_upY

CMPI $1 %r4
BEQ .move_rightY

CMPI $2 %r4
BEQ .move_downY

CMPI $3 %r4
BEQ .move_leftY

# TODO: Change glyphs to be paths
# TODO: Account for collisions by making sure the next block it will move to is not 0.
# TODO: Change glyph to bike not blue square
.move_upY
MOVI $2 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
SUBI $1 %r6
MOVI $0 %rA
ORI $160 %rA
SUB %rA %rB # Move address to new lcoation of bike

# Place bike at new location
STOR %rC %rB
BUC .yellowEnd


.move_rightY
MOVI $2 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
ADDI $1 %r5
ADDI $1 %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .yellowEnd


.move_downY
MOVI $2 %rC
STOR %rC %rB # Place path block for previous bike location

# Increase Y position
ADDI $1 %r6
MOVI $0 %rA
ORI $160 %rA
ADD %rA %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .yellowEnd


.move_leftY
MOVI $2 %rC
STOR %rC %rB # Place path block for previous bike location

# Move bike to new location and update glyph at that new location
SUBI $1 %r5
SUBI $1 %rB # Move address to new location of bike

# Place bike at new location
STOR %rC %rB
BUC .yellowEnd


.yellowEnd


# Restart Counter and Game Loop
MOVI .CounterLoopStart %rF
JUC %rF


.blueDied


.yellowDied


.End
