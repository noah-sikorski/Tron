# Definitions:
# Direction:   0=up 1=right 2=down 3=left
# Blue Bike:   r1=direction r2=xPosition r3=yPosition
# Yellow Bike: r4=direction r5=xPosition r6=yPosition



.StartScreen


.resetGame
LUI $156  %r1
ORI $64   %r1     # Load the value 40000 into r1 for memory wipe

LUI $231   %r2  
ORI $64    $r2    # Load the value 59200 into r2 for end of mem wipe

.memEraseLoop
LOAD %r0 %r1      # remove this part mem
ADDI $1  %r1      # Add 1 mem

CMP %r1 %r2
BNE .memEraseLoop # Jumpback to memErase loop









.StartGame
MOVI $0   %r1   # Up Direction
MOVI $55  %r2   # x = 55
MOVI $40  %r3   # y = 40

MOVI $0   %r4   # Up Direction
MOVI $110 %r5   # x = 110
MOVI $40  %r6   # y = 40


LUI $156  %rA
ORI $64   %rA   #Load 40000 into rA to find in memory
ADD $r2   %rA   #rA 

MOVI $0   %rB
ORI %160  %rB  # Load 160 into rB for memory loc
MUL $r3   %rB  # 160 8 %r3 = y posin memory 

ADD %rA   %rB    # rB holds blue pos in memory

MOVI $1   %rE  
STOR %rE  %rB  #Load blue square into mem



LUI $156 %rA
ORI $64  %rA   #Load 40000 into rA to find in memory
ADD $r5  %rA   #rA 

MOVI $0   %rB
ORI %160  %rB  # Load 160 into rB for memory loc
MUL $r6   %rB  # 160 8 %r3 = y posin memory 

ADD %rA %rB    # rB holds yellow pos in memory

MOVI $2   %rE  
STOR %rE  %rB  #Load Yellow square into mem



.CounterLoopStart
MOVI .CounterLoop %rf
LUI $117 %re
ORI $48  %re
MOVI $0  %rc

.CounterLoop
ADDI $0 %r0
ADDI $0 %r0
ADDI $1 %rc
CMP %re %rc
JNE %rf

.GameLoop
# Check direction and branch accordingly Blue bike
CMPI $0 %r1
BEQ .move_upB

CMPI $1 %r1
BEQ .move_rightB

CMPI $2 %r1
BEQ .move_downB

CMPI $3 %r1
BEQ .move_leftB



.blueBikeMovement
.move_upB:
    # Decrease Y position
    ADDI $1 %r3
    BUC .blueEnd

.move_downB:
    # Increase Y position
    SUBI $1 %r3
    BUC .blueEnd

.move_leftB:
    # Decrease X position
    SUBI $1 %r2
    BUC .blueEnd

.move_rightB:
    # Increase X position
    ADDI $1 %r3
    BUC .blueEnd

.blueEnd
LUI $156 %rA
ORI $64  %rA   #Load 40000 into rA to find in memory
ADD %r2  %rA   # rA is X loc in memory

MOVI $0   %rB
ORI %160 %rB  # Load 160 into rB for memory loc
MUL $r3   %rB  # 160 8 %r3 = y posin memory 

ADD %rA %rB    # rB hodl blue pos in memory

LOAD %rA %rB   # rA holds the value of the glyph
CMPI $0  %rA
BNE .blueDied


.yellowBikeMovement

CMPI $0 %r4
BEQ .move_upY

CMPI $1 %r4
BEQ .move_rightY

CMPI $2 %r4
BEQ .move_downY

CMPI $3 %r4
BEQ .move_leftY


.move_upY:
    # Decrease Y position
    ADDI $1 %r6
    BUC .yellowEnd

.move_downY:
    # Increase Y position
    SUBI $1 %r6
    BUC .yellowEnd

.move_leftY:
    # Decrease X position
    SUBI $1 %r6
    BUC .yellowEnd

.move_rightY:
    # Increase X position
    ADDI $1 %r6
    BUC .yellowEnd

.yellowEnd
LUI $156 %rD
ORI $64  %rD   #Load 40000 into rA to find in memory
ADD %r5  %rD   # rA is X loc in memory

MOVI $0 rE
ORI %160 %rE  # Load 160 into rB for memory loc
MUL $r3   %rE  # 160 8 %r3 = y posin memory 

ADD %rD %rE    # rE hold Yellow pos in memory

LOAD %rD %rE   # rD holds the value of the glyph

CMPI $0  %rD
BNE .yellowDied





MOVI .CounterLoopStart %rf
JUC %rf


.blueDied
.yellowDied

.End
