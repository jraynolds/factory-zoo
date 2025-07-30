extends Entity
class_name Bergy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Spawns a BergyBush instead.
func use(location):
	Map.add_entity(load("res://entities/animals/bergy_bush.tscn").instantiate(), location)
