# GameExample

A tiny Godot 4 game prototype with a simple arcade loop:

- Move the player square around the screen.
- Collect yellow orbs to increase score.
- Collect blue orbs to gain temporary speed boost.
- Reset the run at any time.

## Controls

- Move: `Arrow Keys` or `WASD`
- Reset run: `R`

## Gameplay Rules

- The green square is the player.
- Yellow orb grants `+1` score when collected.
- Blue orb grants a temporary movement speed boost.
- While boosted, the player color changes and HUD shows remaining boost time.
- Reset sets position, score, and boost state back to default.

## Project Structure

- `project.godot`: Godot project settings and input map.
- `scenes/main.tscn`: Main scene and HUD labels.
- `scripts/main.gd`: Player movement, collectibles, boost logic, and UI updates.

## Run Locally

From the repository root:

```bash
godot --path .
```

If your binary is at a custom path:

```bash
/home/agents/LilithKaine/godot --path .
```

## Headless Validation

```bash
/home/agents/LilithKaine/godot --headless --verbose --path . --quit-after 5
/home/agents/LilithKaine/godot --headless --verbose --path . --scene res://scenes/main.tscn --quit-after 5
```
