# Rock-Paper-Scissors Game in RISC-V Assembly

This is a Rock-Paper-Scissors game implemented in RISC-V assembly language for the Ripes RISC-V emulator.

## Game Story

Welcome to the Three Faction War! In the land of Arcadia, three factions—Rock Faction, Paper Faction, and Scissor Faction—battle endlessly for control. Each is driven by their ideals of strength, freedom, and knowledge. Their unyielding conflict has turned the realm into a perpetual warzone. Choose your faction wisely: Rock, Paper, or Scissors.

## How to Run

1. **Install Ripes RISC-V Emulator**
   - Download and install Ripes from [GitHub](https://github.com/mortbopet/Ripes/releases).

2. **Load the Game**
   - Open `war.s` in Ripes.

3. **Assemble and Execute**
   - Click on the **Run** button to start the game.

4. **Gameplay Instructions**
   - **Seed the Game**: When prompted, enter a random number to seed the game's random number generator.
   - **Choose Your Faction**: Enter `1` for Rock, `2` for Paper, or `3` for Scissors.
   - **View Results**: The game will display whether it's a draw, you win, or the computer wins.

## Files

- `war.s` - Main assembly source code of the game.

## Game Mechanics

- **Random Number Generation**: The game uses a Linear Congruential Generator (LCG) seeded with your input to simulate the computer's choice.
- **Outcome Determination**: Your choice is compared against the computer's choice to determine the outcome based on classic Rock-Paper-Scissors rules.

## Requirements

- Ripes RISC-V Emulator

## License

This project is licensed under the MIT License.
