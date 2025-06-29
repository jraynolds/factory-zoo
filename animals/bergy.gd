extends Animal

class_name bergy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func use(loc : Vector2):
	var newBush : Animal = load("res://animals/bergyBush.tscn").instantiate()
	spawning_component.targetSpawn(loc, newBush)
	queue_free()
