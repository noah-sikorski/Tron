.Nocci
MOVI $14 %r1 # set up loop count (go to 14)
MOVI $0 %r2  # Intialize starting point (0) in r2
MOVI $1 %r4  # Intialize the first Fibo. number (1) stored in r4
MOVI $0 %r5  # Ensure that the register that will hold the next Fibo. number is 0 r5
SUBI $1 %r5  # set the second number to -1 to start the sequence. 

MOVI .Calculation %rA      # Stash the address of loop1 into r10
MOVI .inputExport  %rB     # Stash the address of loop2 into r11
.Calculation
CMP %r1 %r0    # Check where the loop is at (if %r1 = 0 jump to inputCheck)
JEQ     %rB   # jump to inputExport loop when done

ADD %r5 %r4    # calculate the next numberin the sequence and store it in %r5

MOV %r4 %r9    # Store the current Fibo. number in r9 temporarily
SUB %r5 %r9    # Store the the current - previous number in r9
MOV %r9 %r5    # Store the previosuly calculated value into r5

SUBI $1 %r1    # Decrement the loop counter by 1 

MOVI $100 %r9  # Store location of Fio. numbers to the 100th spot in memory
ADD  %r2  %r9  # Add the offset to the memory location

STOR %r4 %r9  # Store the calcluated value into the memory + offset location

ADDI $1 %r2    # Increment the offset by 1
JUC %rA        # Jump back to the top of the loop

.inputExport
MOVI $127 %r6       # Store IO/Switch location in the address $127
LOAD %r7 %r6        # Load the switch value into r7
MOVI $100 %r9        # Store the memory address location in r9
ADD %r7  %r9        # Find the spot in memory you want to display by adding the base address value to the switches

LOAD %r3 %r9        # The desired Fibo. number will be laoded into r3

STOR %r3 %r6        # Store the Fibo. number in r3 to r6 in order to actually write to the LEDs
BUC $-6             # Branch back to the .inputExport loop forever
