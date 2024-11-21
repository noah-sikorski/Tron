# Definitions:
# Direction:   0=up 1=right 2=down 3=left
# Blue Bike:   r1=direction r2=xPosition r3=yPosition
# Yellow Bike: r4=direction r5=xPosition r6=yPosition

.StartScreen

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


.StartGame
# Blue Bike Start Registers
MOVI $0   %r1   # Up Direction
MOVI $55  %r2   # x = 55
MOVI $120  %r3   # y = 80


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


.CounterLoopStart
LUI $117 %rE
ORI $48  %rE # Place 30000 as a end to the counter in %rE
MOVI $0  %rC # Clear %rC

.CounterLoop
ADDI $0 %r0 # nop
ADDI $0 %r0 # nop
ADDI $1 %rC # Increment %rC
CMP %rE %rC # Once %rC and %rE are equal continue to game loop
BNE .CounterLoop


.GameLoop

.blueBikeIO
# TODO: Check blue IO and see if direction has changed.
# TODO: If direction has changed, just change the value of %r1.

.blueBikeStart
LUI $156  %rA
ORI $64   %rA  # Load 40000 into rA to find in memory
ADD %r2   %rA  # Shift rA to 40000 + xposition

MOVI $0   %rB
ORI $160  %rB  # Load 160 into rB for memory loc
MUL %r3   %rB  # 160 * %r3 = y position in memory 

ADD %rA   %rB  # rB holds blue pos in memory

# TODO: Find a way to tell if the direction has changed to update glyphs correctly.
# Check direction and branch accordingly Blue bike
CMPI $0 %r1
BEQ .move_upB

CMPI $1 %r1
BEQ .move_rightB

CMPI $2 %r1
BEQ .move_downB

CMPI $3 %r1
BEQ .move_leftB


.move_upB
# TODO: Change glyphs to be paths
MOVI $1 %rC
STOR %rC %rB # Place path block for previous bike location

# TODO: Account for collisions by making sure the next block it will move to is not 0.

# Move bike to new location and update glyph at that new location
SUBI $1  %r3
MOVI $0  %rA
ORI $160 %rA
SUB %rA  %rB # Move address to new lcoation of bike

# TODO: Change glyph to bike not blue square
STOR %rC %rB # Place bike at new location
BUC .blueEnd

# TODO Other direction paint squares

.move_downB
# Increase Y position
ADDI $1 %r3
BUC .blueEnd

.move_leftB
# Decrease X position
SUBI $1 %r2
BUC .blueEnd

.move_rightB
# Increase X position
ADDI $1 %r3
BUC .blueEnd

.blueEnd

# If no characters died, restart the counter and perform the next game loop
BUC .CounterLoopStart


.blueDied


.End

