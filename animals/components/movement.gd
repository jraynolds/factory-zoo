extends Node2D
class_name Movement
## Class for an animal's movement.

@export var movement_interval : float ## The time in seconds between each random movement.
var movement_interval_left : float ## The time in seconds left before a random movement.
@export var grid_size : Vector2 = Vector2(16,16) ## The size of one cell in the grid.

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
		move(Cardinal.values().pick_random())


## Moves the parent in a given direction.
func move(direction: Cardinal):
	var loc = get_parent().position
	var targetLoc = get_parent().position
	loc.y -= grid_size.y
	assert(direction != null, "No given direction!")
	match direction:
		Cardinal.Up:
			targetLoc.y = get_parent().position.y - grid_size.y
		Cardinal.Down:
			targetLoc.y = get_parent().position.y + grid_size.y
		Cardinal.Left:
			targetLoc.x = get_parent().position.x - grid_size.x
		Cardinal.Right:
			targetLoc.x = get_parent().position.x + grid_size.x
	for animal in Map.animal_container.get_children():
		if animal.position == targetLoc:
			return
	get_parent().position = targetLoc
