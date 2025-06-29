extends Node2D
class_name Spawning
## Handles spawning for animals.

var animal_parent : ## getter for the animal parent of this component.
	get :
		print(get_parent().name)
		print(get_parent() as Animal)
		return get_parent() as Animal

@export var spawn_interval : float = 3.0 ## The duration in seconds between each spawn.
var spawn_interval_left : float ## The duration in seconds before the next spawn.

## Called at the beginning.
func _init() -> void:
	spawn_interval_left = spawn_interval


## Called every frame. Spawns on an interval.
func _process(delta: float) -> void:
	spawn_interval_left -= delta
	if spawn_interval_left <= 0:
		spawn_interval_left = spawn_interval
		spawn()


## Spawns a new animal and moves it cardinally.
func spawn():
	var animal = animal_parent.packed_animal.instantiate()
	#var animal = load("res://animals/nouse.tscn").instantiate()
	add_child(animal)
	#print(animal)
	animal.movement_component.move([
		Movement.Cardinal.Up, 
		Movement.Cardinal.Down, 
		Movement.Cardinal.Left, 
		Movement.Cardinal.Right
	].pick_random())

## Spawns a given entity at a given location
func targetSpawn(loc : Vector2, obj):
	Map.animalContainer.add_child(obj)
	obj.position = loc
