# ⚔ "Samurai Jam" (Name to be defined)

A 2D platformer game with action combat. Get in the shoes of an skilled samurai - or a very bad one, depending on YOUR skills - in a journey about... Revenge? Or forgiveness?

## Development Log
### 0.1 (30/12/2023)- Creating the repository and creating the base main character.
Currently, in this stage, the game are being built around the main character mechanics, and every enemy will share some mechanics exctracted from the player character. The state machine, the attack patterns and defense patterns and the platformer movement are some of the functionalities.

### 0.2 (01/01/2024)- Updating the player's state machine
• Adding new states and covering the issues that may come with intense input from the player, such as trying to change into states while already changing to a state. 
• Many "security checks" created.
• Created some generic methods for better readability, such as `should_change_state()` instead of having the list of conditions to change between states in the body of the `update()` method.
• Class `AnimationHandler` created to be scalable and handle (as the name says) the animation of any sprite from any character in the game.
#### TODO:
Keep building the player states. Remaining to do:

**• Attack while Jump/Fall.**

**• In the wall, for walljumping.**

**• Staggering time, for when receiving damage or having it's attack blocked.**
