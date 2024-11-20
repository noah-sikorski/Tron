LUI $156 %r1 
ORI $64 %r1 
LUI $231 %r2 
ORI $64 %r2 
STOR %r0 %r1 
ADDI $1 %r1 
CMP %r1 %r2 
BNE .memEraseLoop 
MOVI $0 %r1 
MOVI $55 %r2 
MOVI $40 %r3 
MOVI $0 %r4 
MOVI $110 %r5 
MOVI $40 %r6 
LUI $156 %rA 
ORI $64 %rA 
ADD %r2 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r3 %rB 
ADD %rA %rB 
MOVI $1 %rE 
STOR %rE %rB 
LUI $156 %rA 
ORI $64 %rA 
ADD %r5 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r6 %rB 
ADD %rA %rB 
MOVI $2 %rE 
STOR %rE %rB 
MOVI .CounterLoop %rf 
LUI $117 %re 
ORI $48 %re 
MOVI $0 %rc 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $1 %rc 
CMP %re %rc 
JNE %rf 
CMPI $0 %r1 
BEQ .move_upB 
CMPI $1 %r1 
BEQ .move_rightB 
CMPI $2 %r1 
BEQ .move_downB 
CMPI $3 %r1 
BEQ .move_leftB 
LUI $156 %rA 
ORI $64 %rA 
ADD %r2 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r3 %rB 
ADD %rA %rB 
MOVI $5 %rA 
STOR %rA %rB 
SUBI $1 %r3 
MOVI $0 %rA 
ORI $160 %rA 
SUB %rA %rB 
BUC .blueEnd 
ADDI $1 %r3 
BUC .blueEnd 
SUBI $1 %r2 
BUC .blueEnd 
ADDI $1 %r3 
BUC .blueEnd 
LUI $156 %rA 
ORI $64 %rA 
ADD %r2 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r3 %rB 
ADD %rA %rB 
LOAD %rA %rB 
CMPI $0 %rA 
BNE .blueDied 
CMPI $0 %r4 
BEQ .move_upY 
CMPI $1 %r4 
BEQ .move_rightY 
CMPI $2 %r4 
BEQ .move_downY 
CMPI $3 %r4 
BEQ .move_leftY 
SUBI $1 %r6 
BUC .yellowEnd 
ADDI $1 %r6 
BUC .yellowEnd 
SUBI $1 %r6 
BUC .yellowEnd 
ADDI $1 %r6 
BUC .yellowEnd 
LUI $156 %rD 
ORI $64 %rD 
ADD %r5 %rD 
MOVI $0 %rE 
ORI $160 %rE 
MUL %r3 %rE 
ADD %rD %rE 
LOAD %rD %rE 
CMPI $0 %rD 
BNE .yellowDied 
MOVI .CounterLoopStart %rf 
JUC %rf 
