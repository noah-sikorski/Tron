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
MOVI $80 %r3 
MOVI $0 %r4 
MOVI $110 %r5 
MOVI $80 %r6 
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
LUI $117 %rE 
ORI $48 %rE 
MOVI $0 %rC 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $1 %rC 
CMP %rE %rC 
BNE .CounterLoop 
LUI $156 %rA 
ORI $64 %rA 
ADD %r2 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r3 %rB 
ADD %rA %rB 
CMPI $0 %r1 
BEQ .move_upB 
CMPI $1 %r1 
BEQ .move_rightB 
CMPI $2 %r1 
BEQ .move_downB 
CMPI $3 %r1 
BEQ .move_leftB 
MOVI $1 %rC 
STOR %rC %rB 
SUBI $1 %r3 
MOVI $0 %rA 
ORI $160 %rA 
SUB %rA %rB 
STOR %rC %rB 
BUC .blueEnd 
ADDI $1 %r3 
BUC .blueEnd 
SUBI $1 %r2 
BUC .blueEnd 
ADDI $1 %r3 
BUC .blueEnd 
LUI $156 %rA 
ORI $64 %rA 
ADD %r5 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r6 %rB 
ADD %rA %rB 
CMPI $0 %r4 
BEQ .move_upY 
CMPI $1 %r4 
BEQ .move_rightY 
CMPI $2 %r4 
BEQ .move_downY 
CMPI $3 %r4 
BEQ .move_leftY 
MOVI $2 %rC 
STOR %rC %rB 
SUBI $1 %r6 
MOVI $0 %rA 
ORI $160 %rA 
SUB %rA %rB 
STOR %rC %rB 
BUC .yellowEnd 
ADDI $1 %r6 
BUC .yellowEnd 
SUBI $1 %r6 
BUC .yellowEnd 
ADDI $1 %r6 
BUC .yellowEnd 
BUC .CounterLoopStart 
