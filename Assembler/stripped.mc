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
LUI .blueUpCases %rF 
MOVI .blueUpCases %rE 
OR %rE %rF 
CMPI $0 %r1 
JEQ %rF 
LUI .blueRightCases %rF 
MOVI .blueRightCases %rE 
OR %rE %rF 
CMPI $1 %r1 
JEQ %rF 
LUI .blueDownCases %rF 
MOVI .blueDownCases %rE 
OR %rE %rF 
CMPI $2 %r1 
JEQ %rF 
LUI .blueLeftCases %rF 
MOVI .blueLeftCases %rE 
OR %rE %rF 
CMPI $3 %r1 
JEQ %rF 
LUI .blueBikeMotion %rF 
MOVI .blueBikeMotion %rE 
OR %rE %rF 
JUC %rF 
LUI .blueBikeMotion %rF 
MOVI .blueBikeMotion %rE 
OR %rE %rF 
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
JUC %rF 
MOVI $1 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $3 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
LUI .blueBikeMotion %rF 
MOVI .blueBikeMotion %rE 
OR %rE %rF 
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
MOVI $0 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $2 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
LUI .blueBikeMotion %rF 
MOVI .blueBikeMotion %rE 
OR %rE %rF 
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
JUC %rF 
MOVI $1 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $3 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
LUI .blueBikeMotion %rF 
MOVI .blueBikeMotion %rE 
OR %rE %rF 
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
MOVI $0 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $2 %r1 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
LUI .move_upB %rF 
MOVI .move_upB %rE 
OR %rE %rF 
CMPI $0 %r1 
JEQ %rF 
LUI .move_rightB %rF 
MOVI .move_rightB %rE 
OR %rE %rF 
CMPI $1 %r1 
JEQ %rF 
LUI .move_downB %rF 
MOVI .move_downB %rE 
OR %rE %rF 
CMPI $2 %r1 
JEQ %rF 
LUI .move_leftB %rF 
MOVI .move_leftB %rE 
OR %rE %rF 
CMPI $3 %r1 
JEQ %rF 
MOVI $4 %rC 
MOVI $0 %rA 
ORI $160 %rA 
ADD %rA %rB 
STOR %rC %rB 
MOVI $0 %rC 
SUBI $1 %rB 
STOR %rC %rB 
ADDI $2 %rB 
STOR %rC %rB 
SUBI $1 %rB 
SUBI $1 %r3 
SUB %rA %rB 
MOVI $26 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $25 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $27 %rC 
STOR %rC %rB 
SUBI $1 %rB 
SUB %rA %rB 
MOVI $23 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $22 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $24 %rC 
STOR %rC %rB 
SUBI $1 %rB 
SUB %rA %rB 
MOVI $20 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $19 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $21 %rC 
STOR %rC %rB 
SUBI $1 %rB 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
MOVI $3 %rC 
MOVI $0 %rA 
ORI $160 %rA 
SUBI $1 %rB 
STOR %rC %rB 
MOVI $0 %rC 
ADD %rA %rB 
STOR %rC %rB 
SUB %rA %rB 
SUB %rA %rB 
STOR %rC %rB 
ADD %rA %rB 
ADDI $1 %r2 
ADDI $1 %rB 
MOVI $13 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $10 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $16 %rC 
STOR %rC %rB 
SUB %rA %rB 
ADDI $1 %rB 
MOVI $14 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $11 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $17 %rC 
STOR %rC %rB 
SUB %rA %rB 
ADDI $1 %rB 
MOVI $15 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $12 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $18 %rC 
STOR %rC %rB 
SUB %rA %rB 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
MOVI $4 %rC 
MOVI $0 %rA 
ORI $160 %rA 
SUB %rA %rB 
STOR %rC %rB 
MOVI $0 %rC 
SUBI $1 %rB 
STOR %rC %rB 
ADDI $2 %rB 
STOR %rC %rB 
SUBI $1 %rB 
ADDI $1 %r3 
ADD %rA %rB 
MOVI $26 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $25 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $27 %rC 
STOR %rC %rB 
SUBI $1 %rB 
ADD %rA %rB 
MOVI $23 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $22 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $24 %rC 
STOR %rC %rB 
SUBI $1 %rB 
ADD %rA %rB 
MOVI $20 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $19 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $21 %rC 
STOR %rC %rB 
SUBI $1 %rB 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
MOVI $3 %rC 
MOVI $0 %rA 
ORI $160 %rA 
ADDI $1 %rB 
STOR %rC %rB 
MOVI $0 %rC 
ADD %rA %rB 
STOR %rC %rB 
SUB %rA %rB 
SUB %rA %rB 
STOR %rC %rB 
ADD %rA %rB 
SUBI $1 %r2 
SUBI $1 %rB 
MOVI $13 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $10 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $16 %rC 
STOR %rC %rB 
SUB %rA %rB 
SUBI $1 %rB 
MOVI $14 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $11 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $17 %rC 
STOR %rC %rB 
SUB %rA %rB 
SUBI $1 %rB 
MOVI $15 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $12 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $18 %rC 
STOR %rC %rB 
SUB %rA %rB 
LUI .blueEnd %rF 
MOVI .blueEnd %rE 
OR %rE %rF 
JUC %rF 
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
LUI .yellowUpCases %rF 
MOVI .yellowUpCases %rE 
OR %rE %rF 
CMPI $0 %r4 
JEQ %rF 
LUI .yellowRightCases %rF 
MOVI .yellowRightCases %rE 
OR %rE %rF 
CMPI $1 %r4 
JEQ %rF 
LUI .yellowDownCases %rF 
MOVI .yellowDownCases %rE 
OR %rE %rF 
CMPI $2 %r4 
JEQ %rF 
LUI .yellowLeftCases %rF 
MOVI .yellowLeftCases %rE 
OR %rE %rF 
CMPI $3 %r4 
JEQ %rF 
LUI .yellowBikeMotion %rF 
MOVI .yellowBikeMotion %rE 
OR %rE %rF 
JUC %rF 
LUI .yellowBikeMotion %rF 
MOVI .yellowBikeMotion %rE 
OR %rE %rF 
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
JUC %rF 
JUC %rF 
MOVI $1 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $3 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
LUI .yellowBikeMotion %rF 
MOVI .yellowBikeMotion %rE 
OR %rE %rF 
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
JUC %rF 
MOVI $0 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $2 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
LUI .yellowBikeMotion %rF 
MOVI .yellowBikeMotion %rE 
OR %rE %rF 
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
JUC %rF 
JUC %rF 
MOVI $1 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $3 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
LUI .yellowBikeMotion %rF 
MOVI .yellowBikeMotion %rE 
OR %rE %rF 
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
JUC %rF 
MOVI $0 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
MOVI $2 %r4 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
JUC %rF 
LUI .move_upY %rF 
MOVI .move_upY %rE 
OR %rE %rF 
CMPI $0 %r4 
JEQ %rF 
LUI .move_rightY %rF 
MOVI .move_rightY %rE 
OR %rE %rF 
CMPI $1 %r4 
JEQ %rF 
LUI .move_downY %rF 
MOVI .move_downY %rE 
OR %rE %rF 
CMPI $2 %r4 
JEQ %rF 
LUI .move_leftY %rF 
MOVI .move_leftY %rE 
OR %rE %rF 
CMPI $3 %r4 
JEQ %rF 
MOVI $29 %rC 
MOVI $0 %rA 
ORI $160 %rA 
ADD %rA %rB 
STOR %rC %rB 
MOVI $0 %rC 
SUBI $1 %rB 
STOR %rC %rB 
ADDI $2 %rB 
STOR %rC %rB 
SUBI $1 %rB 
SUBI $1 %r6 
SUB %rA %rB 
MOVI $51 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $50 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $52 %rC 
STOR %rC %rB 
SUBI $1 %rB 
SUB %rA %rB 
MOVI $48 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $47 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $48 %rC 
STOR %rC %rB 
SUBI $1 %rB 
SUB %rA %rB 
MOVI $45 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $44 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $46 %rC 
STOR %rC %rB 
SUBI $1 %rB 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
MOVI $28 %rC 
MOVI $0 %rA 
ORI $160 %rA 
SUBI $1 %rB 
STOR %rC %rB 
MOVI $0 %rC 
ADD %rA %rB 
STOR %rC %rB 
SUB %rA %rB 
SUB %rA %rB 
STOR %rC %rB 
ADD %rA %rB 
ADDI $1 %r5 
ADDI $1 %rB 
MOVI $38 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $35 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $41 %rC 
STOR %rC %rB 
SUB %rA %rB 
ADDI $1 %rB 
MOVI $39 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $36 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $42 %rC 
STOR %rC %rB 
SUB %rA %rB 
ADDI $1 %rB 
MOVI $40 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $37 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $43 %rC 
STOR %rC %rB 
SUB %rA %rB 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
MOVI $29 %rC 
MOVI $0 %rA 
ORI $160 %rA 
SUB %rA %rB 
STOR %rC %rB 
MOVI $0 %rC 
SUBI $1 %rB 
STOR %rC %rB 
ADDI $2 %rB 
STOR %rC %rB 
SUBI $1 %rB 
ADDI $1 %r6 
ADD %rA %rB 
MOVI $51 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $50 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $52 %rC 
STOR %rC %rB 
SUBI $1 %rB 
ADD %rA %rB 
MOVI $48 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $47 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $49 %rC 
STOR %rC %rB 
SUBI $1 %rB 
ADD %rA %rB 
MOVI $45 %rC 
STOR %rC %rB 
SUBI $1 %rB 
MOVI $44 %rC 
STOR %rC %rB 
ADDI $2 %rB 
MOVI $46 %rC 
STOR %rC %rB 
SUBI $1 %rB 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
MOVI $28 %rC 
MOVI $0 %rA 
ORI $160 %rA 
ADDI $1 %rB 
STOR %rC %rB 
MOVI $0 %rC 
ADD %rA %rB 
STOR %rC %rB 
SUB %rA %rB 
SUB %rA %rB 
STOR %rC %rB 
ADD %rA %rB 
SUBI $1 %r5 
SUBI $1 %rB 
MOVI $38 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $35 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $41 %rC 
STOR %rC %rB 
SUB %rA %rB 
SUBI $1 %rB 
MOVI $39 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $36 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $42 %rC 
STOR %rC %rB 
SUB %rA %rB 
SUBI $1 %rB 
MOVI $40 %rC 
STOR %rC %rB 
SUB %rA %rB 
MOVI $37 %rC 
STOR %rC %rB 
ADD %rA %rB 
ADD %rA %rB 
MOVI $43 %rC 
STOR %rC %rB 
SUB %rA %rB 
LUI .yellowEnd %rF 
MOVI .yellowEnd %rE 
OR %rE %rF 
JUC %rF 
LUI .CounterLoopStart %rF 
MOVI .CounterLoopStart %rE 
OR %rE %rF 
JUC %rF 
