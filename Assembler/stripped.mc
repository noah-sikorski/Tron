LUI $156 %r1 
ORI $64 %r1 
LUI $231 %r2 
ORI $64 %r2 
STOR %r0 %r1 
ADDI $1 %r1 
CMP %r1 %r2 
BNE .memEraseLoop 
LUI $234 %r7 
ORI $96 %r7 
LOAD %r8 %r7 
LUI $1 %r9 
CMP %r9 %r8 
BNE .StartScreen 
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
LUI $156 %rE 
ORI $64 %rE 
MOVI $0 %rC 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $0 %r0 
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
LUI $234 %r7 
ORI $96 %r7 
LOAD %r8 %r7 
CMPI $0 %r1 
BEQ .blueUpCases 
CMPI $1 %r1 
BEQ .blueRightCases 
CMPI $2 %r1 
BEQ .blueDownCases 
CMPI $3 %r1 
BEQ .blueLeftCases 
BUC .blueBikeMotion 
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
BUC .blueBikeMotion 
MOVI $1 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
MOVI $3 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
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
MOVI $0 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
MOVI $2 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
BUC .blueBikeMotion 
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
BUC .blueBikeMotion 
MOVI $1 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
MOVI $3 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
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
MOVI $0 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
MOVI $2 %r1 
BUC .blueEnd 
BUC .blueBikeMotion 
BUC .blueBikeMotion 
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
MOVI $1 %rC 
STOR %rC %rB 
ADDI $1 %r2 
ADDI $1 %rB 
STOR %rC %rB 
BUC .blueEnd 
MOVI $1 %rC 
STOR %rC %rB 
ADDI $1 %r3 
MOVI $0 %rA 
ORI $160 %rA 
ADD %rA %rB 
STOR %rC %rB 
BUC .blueEnd 
MOVI $1 %rC 
STOR %rC %rB 
SUBI $1 %r2 
SUBI $1 %rB 
STOR %rC %rB 
BUC .blueEnd 
LUI $156 %rA 
ORI $64 %rA 
ADD %r5 %rA 
MOVI $0 %rB 
ORI $160 %rB 
MUL %r6 %rB 
ADD %rA %rB 
LUI $234 %r7 
ORI $96 %r7 
LOAD %r8 %r7 
CMPI $0 %r4 
BEQ .yellowUpCases 
CMPI $1 %r4 
BEQ .yellowRightCases 
CMPI $2 %r4 
BEQ .yellowDownCases 
CMPI $3 %r4 
BEQ .yellowLeftCases 
BUC .yellowBikeMotion 
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
BUC .yellowBikeMotion 
MOVI $1 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
MOVI $3 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
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
MOVI $0 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
MOVI $2 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
BUC .yellowBikeMotion 
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
BUC .yellowBikeMotion 
MOVI $1 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
MOVI $3 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
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
MOVI $0 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
MOVI $2 %r4 
BUC .yellowEnd 
BUC .yellowBikeMotion 
BUC .yellowBikeMotion 
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
MOVI $2 %rC 
STOR %rC %rB 
ADDI $1 %r5 
ADDI $1 %rB 
STOR %rC %rB 
BUC .yellowEnd 
MOVI $2 %rC 
STOR %rC %rB 
ADDI $1 %r6 
MOVI $0 %rA 
ORI $160 %rA 
ADD %rA %rB 
STOR %rC %rB 
BUC .yellowEnd 
MOVI $2 %rC 
STOR %rC %rB 
SUBI $1 %r5 
SUBI $1 %rB 
STOR %rC %rB 
BUC .yellowEnd 
MOVI .CounterLoopStart %rF 
JUC %rF 
