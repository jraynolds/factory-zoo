extends Node2D
class_name Movement
## Class for animal movement on a grid.

@export var movement_interval : float ## The time in seconds between each random movement.
var movement_interval_left : float ## The time in seconds left before a random movement.
@export var grid_size : Vector2 = Vector2(60,60) ## The size of one cell in the grid.

enum Cardinal { ## Cardinal directions for movement.
	Up,
	Down,
	Left,
	Right
}

## Called every frame. Moves randomly at an interval.
func _process(delta: float) -> void:
	movement_interval_left -= delta
	if movement_interval_left <= 0:
		movement_interval_left = movement_interval
		move([Cardinal.Up, Cardinal.Down, Cardinal.Left, Cardinal.Right].pick_random())


## Moves the parent in a given direction.
func move(direction: Cardinal):
	assert(direction != null, "No given direction!")
	match direction:
		Cardinal.Up:
			get_parent().position.y -= grid_size.y
		Cardinal.Down:
			get_parent().position.y += grid_size.y
		Cardinal.Left:
			get_parent().position.x -= grid_size.x
		Cardinal.Right:
			get_parent().position.x += grid_size.x
