extends Node2D

@export var animal_container : Node2D ## Container for all animals on this map.
#var animals : Array[Animal] : ## Getter for all animals in the container.
	#get :
		#return animal_container.get_children().filter(func(child): return child as Animal)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


## Adds the given animal at the given location.
func add_animal(animal: Animal, location: Vector2):
	animal_container.add_child(animal)
	#animals.append(animal)
	animal.position = location
