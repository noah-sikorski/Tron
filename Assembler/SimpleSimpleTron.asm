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


.tempTest
LUI $156  %rA
ORI $64   %rA  # %rA = 40000 (top left corner)
MOVI $2   %rB  # %rB = yellow glyph
STOR %rB  %rA  # Top left corner is yellow

MOVI $0   %rC
ORI $159  %rC
ADD %rC %rA  # %rA = 40159 (top right corner)
STOR %rB  %rA  # Top right corner is yellow

LUI $231  %rA
ORI $63   %rA  # %rA = 59199 (bottom right corner)
STOR %rB  %rA  # Bottom Right corner is yellow

SUB %rC %rA  # %rA = 59040 (bottom left corner)
STOR %rB  %rA  # Bottom Left corner is yellow
