# Godot Game Template

A flexible diecut template for creating games in Godot 4.x with configurable features.

## What This Creates

This template generates a Godot game project with:

- **Core (always included):**
  - Single player character with smooth movement mechanics
  - Dash ability with recharge system
  - Basic physics and collision handling
  - Minimal, clean project structure

- **Optional features (toggle during generation):**
  - 🎮 **Multiplayer support** - Up to 3 players with keyboard and gamepad controls
  - 🤖 **Bot players** - AI-controlled players (requires multiplayer)
  - 📊 **UI elements** - Score tracking, winner screen, reset button (requires multiplayer)

## Usage

```bash
diecut new godot-tag-game
```

You'll be prompted for:
- **Project name** - Name of your game project
- **Author** - Your name
- **Description** - Brief description of your game
- **Godot version** - Godot version (default: 4.3)
- **Include multiplayer?** - Enable multi-player support
- **Include bots?** - Add AI players (if multiplayer enabled)
- **Include UI?** - Add score/winner screens (if multiplayer enabled)

### Examples

**Minimal single-player game:**
```bash
diecut new godot-tag-game \
  -d project_name=my-game \
  -d include_multiplayer=false
```

**Full-featured multiplayer tag game:**
```bash
diecut new godot-tag-game \
  -d project_name=tag-arena \
  -d include_multiplayer=true \
  -d include_bots=true \
  -d include_ui=true
```

## What's Included

Always included:
- `project.godot` - Godot project configuration
- `main.tscn` - Main game scene
- `level.gd` - Level management
- `scenes/base_player.gd` - Player movement and physics
- `scenes/player.tscn` - Player scene
- Game assets (sprites, icons)

Conditionally included:
- `scenes/bot_player.gd` - Bot AI (if `include_bots=true`)
- `utils/tag.gd` - Tag manager (if `include_multiplayer=true`)
- `utils/score.gd`, `utils/winner.gd`, `utils/reset_button.gd` - UI scripts (if `include_ui=true`)

## Getting Started After Generation

1. Open the generated `project.godot` in Godot Editor
2. Press F5 to run the game
3. Start customizing the gameplay, graphics, and mechanics!

## Customization Ideas

- Add new player abilities or power-ups
- Create multiple levels or arenas
- Implement different game modes
- Add obstacles and environmental hazards
- Enhance visuals with particles and effects
- Add sound effects and music

## Requirements

- Godot 4.3 or later
- Controllers (optional, for multiplayer)

## Template Features

This template demonstrates several diecut features:
- **Conditional variables** - `include_bots` and `include_ui` only appear if `include_multiplayer=true`
- **Conditional files** - Bot and UI scripts only included when relevant
- **Tera templating** - Code conditionally includes/excludes features based on variables

## License

Template and generated code are free to use for any purpose.
