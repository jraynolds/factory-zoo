extends Node2D
class_name Spawning
## Class for an animal's spawning.

var animal_parent : ## getter for the animal parent of this component.
	get :
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

## Spawns a new animal and moves it cardinally. should do move check first to save time
func spawn():
	var animal = animal_parent.packed_animal.instantiate()
	animal.packed_animal = animal_parent.packed_animal
	Map.add_animal(animal, get_parent().position)
	var rand = randi_range(0, 3)
	while animal.position == animal_parent.position:
		animal.movement_component.move(Movement.Cardinal.values().pick_random())
	for i in range (4):
		animal.movement_component.move(Movement.Cardinal.values()[(i + rand)%4])
		if animal.position != animal_parent.position:
			return
	animal.queue_free()

## Spawns a given entity at a given location
func targetSpawn(loc : Vector2, obj):
	Map.animalContainer.add_child(obj)
	obj.position = loc
