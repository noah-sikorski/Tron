MOVI $0 %r1 
MOVI $210 %r2 
MOVI $200 %r3 
MOVI $0 %r4 
LUI $1 %r5 
ORI $164 %r5 
MOVI $200 %r6 
MOVI .CounterLoop %rf 
LUI $117 %re 
ORI $48 %re 
MOVI $0 %rc 
ADDI $0 %r0 
ADDI $0 %r0 
ADDI $1 %rc 
CMP %re %rc 
JNE %rf 
MOVI .CounterLoopStart %rf 
JUC %rf 
