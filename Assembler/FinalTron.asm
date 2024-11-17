# Definitions:
# Direction:   0=up 1=right 2=down 3=left
# Blue Bike:   r1=direction r2=xPosition r3=yPosition
# Yellow Bike: r4=direction r5=xPosition r6=yPosition
.StartScreen



.StartGame
MOVI $0   %r1   # Up Direction
MOVI $55  %r2   # x = 55
MOVI $40  %r3   # y = 40

MOVI $0   %r4   # Up Direction
MOVI $110 %r5   # x = 110
MOVI $40  %r6   # y = 40

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


MOVI .CounterLoopStart %rf
JUC %rf

.End
