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
	if !is_visible_in_tree(): ## Skip spawning if this component is invisible.
		return
	if !spawning:
		return
	spawn_interval_left -= delta
	if spawn_interval_left <= 0:
		spawn_interval_left = spawn_interval
		spawn()

func spawnOther(spawned_entity : Entity, spawn_location = Map.get_random_empty_neighbor_location(get_parent().position)):
	spawned_entity.visible = false
	assert(spawn_location != null, "We couldn't find a valid neighboring location!")
	Map.add_entity(spawned_entity, spawn_location)
	
## Spawns a new entity copy of us.
## If it can move, it moves cardinally. 
## should do move check first to save time
## [I] Moved this into spawnOther but left notes because idk wtf is going on
func spawn():
	var spawned_entity = load(get_parent().scene_file_path).instantiate()
	spawnOther(spawned_entity)
