#Define constants
.NumberFive
#1
MOVI $1 %r5
MOVI $1 %r6
LSHI $15 %r5
STOR %r6 %r5
MOVI $100 %r1 #Put 100 in register 1
MOVI $255 %rA #Put and address location in register 10
MOVI $254 %rB #Load address for 5
STOR %r1 %rA #Store 100 at the address in %rA
LOAD %r2 %rA #Load the value in The address at %rA in %r2

#2
ADD %r1 %r2 #R2 holds 200 now
ADD %r1 %r2 #R2 should hold 300 (Causing overflow)

#3
STOR %r2 %rA #store 300(ish) in ra

#4
LOAD %r3 %rA #Load it back into another Register

#5 & 6 
CMPI $0 %r3
BNE .NumberFive
MOVI $255 %r4

.NumberFive
STOR %r3 %rB


