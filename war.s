# Rock-Paper-Scissors Game in RISC-V
# 1 - Rock, 2 - Paper, 3 - Scissors

.data
player_choice: .word 0     # Reserve space for player's choice
computer_choice: .word 0   # Reserve space for computer's choice
result_message: .string "Result: "
draw_message: .string "It's a draw!\n"
player_wins_message: .string "\nPlayer wins!\n"
computer_wins_message: .string "\nComputer wins!\n"
player_choice_msg: .string "Enter 1 for Rock, 2 for Paper, or 3 for Scissors: "
story_message: .string "Welcome to the Three Faction War!\nIn the land of Arcadia three factions—Rock Faction, Paper Faction, and the Scissor Faction—battle endlessly for control, each driven by their ideals of strength, freedom, and knowledge. Their unyielding conflict has turned the realm into a perpetual warzone, where alliances are fleeting, and victory is never absolute.\nChoose your faction wisely: Rock, Paper, or Scissors.\n"
seed_prompt_msg: .string "Now Enter a random number to seed the game: "
s: .zero 12                # Reserve space for input string
seed_addr: .word 12345     # Initial seed for LCG

.text
.globl main
main:
    # Step 1: Display the story
    li a7, 4                 # Syscall code for print_string
    la a0, story_message     # Load address of story message
    ecall

    # Step 2: Get seed from user
    li a7, 4                 # Syscall code for print_string
    la a0, seed_prompt_msg   # Load address of seed prompt message
    ecall

    # Read seed input using the input_taker mechanism
    addi a0, x0, 0           # stdin = 0
    la a1, s                 # Load address of input string
    addi a2, x0, 10          # Reading 10 chars max
    addi a7, x0, 63          # Syscall code for read_string
    ecall

    # Convert seed input string to integer
    addi a0, x0, 0
    addi x6, x0, 10
stoi_seed:
    lbu x5, 0(a1)
    beq x5, x6, exit_stoi_seed
    addi x5, x5, -48
    mul a0, a0, x6
    add a0, a0, x5
    addi a1, a1, 1
    jal x0, stoi_seed
exit_stoi_seed:
    la t0, seed_addr         # Load address of seed variable
    sw a0, 0(t0)             # Store seed in memory

    # Step 3: Get player's choice
    li a7, 4                 # Syscall code for print_string
    la a0, player_choice_msg # Load address of prompt message
    ecall

    # Read player input using the input_taker mechanism
    addi a0, x0, 0           # stdin = 0
    la a1, s                 # Load address of input string
    addi a2, x0, 10          # Reading 10 chars max
    addi a7, x0, 63          # Syscall code for read_string
    ecall

    # Convert player input string to integer
    addi a0, x0, 0
    addi x6, x0, 10
stoi_player:
    lbu x5, 0(a1)
    beq x5, x6, exit_stoi_player
    addi x5, x5, -48
    mul a0, a0, x6
    add a0, a0, x5
    addi a1, a1, 1
    jal x0, stoi_player
exit_stoi_player:
    la t0, player_choice      # Load address of player_choice variable
    sw a0, 0(t0)              # Store player's choice in memory

    # Step 4: Generate computer's random choice using LCG
    la t3, seed_addr          # Load address of seed memory
    lw t0, 0(t3)              # Load value from memory as the seed
    
generate_random:
    li t1, 1103515245         # Multiplier for LCG
    mul t0, t0, t1            # t0 = t0 * multiplier
    li t1, 12345              # Increment for LCG
    add t0, t0, t1            # t0 = t0 + increment
    andi t1, t0, 3            # Get last two bits (values 0, 1, 2, or 3)
    addi t1, t1, 1            # Map range to 1, 2, 3
    sw t0, 0(t3)              # Update the seed in memory for future use
    la t2, computer_choice    # Load address of computer_choice variable
    sw t1, 0(t2)              # Store computer's choice in memory

    # Step 5: Compare choices and determine the winner
    la t0, player_choice
    lw t0, 0(t0)
    la t1, computer_choice
    lw t1, 0(t1)
    beq t0, t1, draw

    # Player is Rock
    li t2, 1
    beq t0, t2, check_rock

    # Player is Paper
    li t2, 2
    beq t0, t2, check_paper

    # Player is Scissors
    li t2, 3
    beq t0, t2, check_scissors

# --- Rock Battle Logic ---
check_rock:
    li t2, 3
    beq t1, t2, player_wins
    j computer_wins

# --- Paper Battle Logic ---
check_paper:
    li t2, 1
    beq t1, t2, player_wins
    j computer_wins

# --- Scissors Battle Logic ---
check_scissors:
    li t2, 2
    beq t1, t2, player_wins
    j computer_wins

# --- Outcomes ---
draw:
    li a7, 4
    la a0, draw_message
    ecall
    j end_game

player_wins:
    li a7, 4
    la a0, player_wins_message
    ecall
    j end_game

computer_wins:
    li a7, 4
    la a0, computer_wins_message
    ecall

end_game:
    li a7, 10
    ecall