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

## Returns a location one grid movement away.
static func get_location_from_movement(starting_location: Vector2, movement: Cardinal, cell_distance: float=16):
	assert(starting_location != null, "No starting location to move from!")
	assert(movement != null, "No movement to find a location from!")
	match movement:
		Cardinal.Up:
			return starting_location + Vector2(0, -cell_distance)
		Cardinal.Down:
			return starting_location + Vector2(0, cell_distance)
		Cardinal.Left:
			return starting_location + Vector2(-cell_distance, 0)
		Cardinal.Right:
			return starting_location + Vector2(cell_distance, 0)


## Returns a randomized array of cardinal movements.
static func get_random_cardinal_directions():
	var movements = [Movement.Cardinal.Up, Movement.Cardinal.Down, Movement.Cardinal.Right, Movement.Cardinal.Down]
	movements.shuffle()
	return movements

## Called every frame. Moves randomly at an interval.
func _process(delta: float) -> void:
	movement_interval_left -= delta
	if movement_interval_left <= 0:
		movement_interval_left = movement_interval
		move(Cardinal.values().pick_random())

## Moves the parent in a given direction.
func move(direction: Cardinal):
	var target_loc = Movement.get_location_from_movement(get_parent().position, direction)
	if can_move_to(target_loc):
		get_parent().position = target_loc

## Returns whether we can move to the given location.
func can_move_to(location: Vector2):
	if Map.get_entity_at_location(location):
		return false
	return true
