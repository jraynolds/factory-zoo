extends Node2D
class_name Spawning
## Class for an entity's spawning.

var animal_parent : ## getter for the animal parent of this component.
	get :
		return get_parent() as Animal

@export var spawning : bool ## Whether we should spawn.
@export var spawn_interval : float = 3.0 ## The duration in seconds between each spawn.
var spawn_interval_left : float ## The duration in seconds before the next spawn.

## Called at the beginning.
func _init() -> void:
	spawn_interval_left = spawn_interval

## Called every frame. Spawns on an interval.
func _process(delta: float) -> void:
	if !spawning:
		return
	spawn_interval_left -= delta
	if spawn_interval_left <= 0:
		spawn_interval_left = spawn_interval
		spawn()

## Spawns a new entity copy of us.
## If it can move, it moves cardinally. 
## should do move check first to save time
func spawn():
	var spawn_location = Map.get_random_empty_neighbor_location(get_parent().position)
	var spawned_entity = load(get_parent().scene_file_path).instantiate()
	spawned_entity.visible = false
	#var duplicate = get_parent().duplicate(7) ## 7 is the bitwise flag for "copy everything"
	#var duplicate = get_parent() ## 7 is the bitwise flag for "copy everything"
	assert(spawn_location != null, "We couldn't find a valid neighboring location!")
	Map.add_entity(spawned_entity, spawn_location)
	#var animal = animal_parent.packed_animal.instantiate()
	#animal.packed_animal = animal_parent.packed_animal
	#Map.add_animal(animal, get_parent().position)
	#var rand = randi_range(0, 3)
	#while animal.position == animal_parent.position:
		#animal.movement_component.move(Movement.Cardinal.values().pick_random())
	#for i in range (4):
		#animal.movement_component.move(Movement.Cardinal.values()[(i + rand)%4])
		#if animal.position != animal_parent.position:
			#return
	#animal.queue_free()

### Spawns a given entity at a given location
#func targetSpawn(loc : Vector2, obj):
	#Map.animalContainer.add_child(obj)
	#obj.position = loc
