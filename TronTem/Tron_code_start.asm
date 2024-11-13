# Data section (if assembler does this?????)
.player_x:
    .word 0          # Reserve 2 bytes for player_x
.player_y:
    .word 0          # Reserve 2 bytes for player_y
.direction:
    .word 0          # Reserve 2 bytes for direction
.INPUT_ADDR:
    .word 0xFFFF     # Physical switch input address


# Define constants (labels will be assigned addresses by the assembler)
.player_x          # Label for player's X position in memory
.player_y          # Label for player's Y position in memory
.direction         # Label for player's direction in memory
.INPUT_ADDR        # Label for physical switch input address
.no_change
.move_up           # 0 is up in memory
.move_down         # 1 is down in memory
.move_left         # 2 is left in memory
.move_right        # 3 is right in memory
.loop

# Initialize registers with variable addresses

#Go back to this later yo may need to use LUI to load to a diffferent spot in memory
MOVI $255 %rA    # Load low byte of address of player_x into %rA ##change to pos in memory

MOVI $254 %rB    # Load low byte of address of player_y into %rB ##change to pos in memory


MOVI $253  %rC   # Load low byte of address of direction into %rC ##change to pos in memory


MOVI $252 %rD  # Load low byte of INPUT_ADDR into %rD


#This is where we initialize startin pos (decision)
        # Initialize player's position using decimal values
        MOVI $100 %r1          # Load low byte of 100 into %r1
       

        MOVI $200 %r2          # Load low byte of 200 into %r2
        

        STOR %r1 %rA           # Store %r1 into [player_x]
        STOR %r2 %rB           # Store %r2 into [player_y]

        # Initialize direction to Up (0)
        MOVI $0 %r3
        STOR %r3 %rC           # Store %r3 into [direction]

# Main loop
.loop:

# Read input from physical switch
LOAD %r4 %rD           # %r4 = [INPUT_ADDR]

# Load current direction
LOAD %r5 %rC           # %r5 = [direction]

# Where are we storing the flags so the code can access it?(Decsion)
        # Compare input with current direction
        CMP %r5 %r4            # Performs %r5 - %r4
        BEQ .no_change         # If equal, skip direction update

# Update direction
STOR %r4 %rC           # [direction] = %r4 (new input)

.no_change:

# Load direction into %r3 for decision-making
LOAD %r3 %rC           # %r3 = [direction]

# Check direction and branch accordingly
CMPI $0 %r3
BEQ .move_up

CMPI $1 %r3
BEQ .move_down

CMPI $2 %r3
BEQ .move_left

CMPI $3 %r3
BEQ .move_right

# If direction is invalid, loop back
BUC .loop

# Movement subroutines
.move_up:
    # Decrease Y position
    LOAD %r2 %rB        # %r2 = [player_y]
    SUBI $10 %r2        # %r2 = %r2 - 10
    STOR %r2 %rB        # [player_y] = %r2
    BUC .loop

.move_down:
    # Increase Y position
    LOAD %r2 %rB
    ADDI $10 %r2        # %r2 = %r2 + 10
    STOR %r2 %rB
    BUC .loop

.move_left:
    # Decrease X position
    LOAD %r1 %rA        # %r1 = [player_x]
    SUBI $10 %r1        # %r1 = %r1 - 10
    STOR %r1 %rA
    BUC .loop

.move_right:
    # Increase X position
    LOAD %r1 %rA
    ADDI $10 %r1        # %r1 = %r1 + 10
    STOR %r1 %rA
    BUC .loop