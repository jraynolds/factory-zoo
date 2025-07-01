extends Animal

class_name bergyBush

var watered : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics():
	for animal in Map.animal_container.get_children():
		if animal is Water:
			if  position.distance_to(animal.position)< 16:
				watered = true
				return
	watered = false
	return				
