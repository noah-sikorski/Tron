#Define constants
.NumberFive
#1

MOVI $100 %r1 #Put 100 in register 1

MOVI $100 %rA # Addresses for 
MOVI $101 %rB 
MOVI $102 %rC 
MOVI $103 %rD 
MOVI $104 %rE 

MOVI $1 %r1
MOVI $2 %r2
MOVI $3 %r3
MOVI $4 %r4
MOVI $5 %r5

STOR %r1 %rA
STOR %r2 %rB
STOR %r3 %rC
STOR %r4 %rD
STOR %r5 %rE

CMP  %r0 %r0
BEQ .NumberFive
MOVI $0 %r0
MOVI $255 %r4
MOVI $255 %r5



.NumberFive
LOAD %r5 %rA
LOAD %r4 %rB
LOAD %r3 %rC
LOAD %r2 %rD
LOAD %r1 %rE

.runMEM # WE are HERE
ADDI $100 %r8
LOAD %r6 %r8
ADDI $50 %r6
LOAD %r7 %r6
STOR %r7 %r8
BUC .runMEM
ADDI $0 %r0






