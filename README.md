# Submarines

## Overview

**Submarines** is an exciting game where you control a ship and drop bombs to hit submarines. Use the controls to navigate and drop bombs in the right position to succeed!

![demo](/screenshot.png)

### How To Play
- [▶]: Move the ship to the right
- [◀]: Move the ship to the left
- [Z]: Drop a bomb on the left side of the ship
- [X]: Drop a bomb in the middle of the ship
- [C]: Drop a bomb on the right side of the ship
- [R]: Restart the game
- [Esc]: Exit the game (close window)

## Requirements

To run this game, ensure you have the following:

- Ruby 2.6 or later
- `gosu` gem [Getting Started on macOS](https://github.com/gosu/gosu/wiki/Getting-Started-on-OS-X)
- SDL2 library (required by `gosu`)

### Installation and Setup

Follow these steps to set up the project on your system:

1. Install Ruby 2.6+: Make sure Ruby 2.6 or later is installed.
2. Set Up GEM_HOME (for managing gems): Open your shell configuration file (~/.zshrc if you use Zsh):
    1. `nano ~/.zshrc`
    2. Add the following line to set the GEM_HOME environment variable: `export GEM_HOME="$HOME/.gem"`
    3. Save and close the file, then apply the changes: `source ~/.zshrc`
3. Install SDL2: Use Homebrew to install SDL2, which is required by gosu: `brew install sdl2`
4. Clone the Repository: Navigate to your desired directory and clone the repository: `cd submarines`
5. Install Project Dependencies: Use Bundler to install the required gems: `bundle install`
5. Run the Game: Start the game by running the main Ruby script: `ruby main.rb`

## Credit
* Background Music: [The Looming!](https://opengameart.org/content/the-looming) by Snabisch
* Sound Effect: [Explosion](https://opengameart.org/content/explosion-0)
