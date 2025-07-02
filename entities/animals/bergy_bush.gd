extends Entity
class_name BergyBush

var watered : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if watered:
		spawning_component.spawnOther(load("res://entities/bergy.gd").instantiate())
	

func _physics():
	for obj in Map.entity_container.entities():
		var water = obj as Water
		if water:
			if  position.distance_to(obj.position)<= 16:
				watered = true
				return
	watered = false
	return
