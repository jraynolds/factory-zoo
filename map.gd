extends Node2D

@export var animal_container : Node2D ## Container for all animals on this map.
#var animals : Array[Animal] : ## Getter for all animals in the container.
	#get :
		#return animal_container.get_children().filter(func(child): return child as Animal)

#var locContents = {} ## Vector2 locations mapped to array of animals

##func getContents(loc : Vector2):
	
	# Adds a new animal to the array in that location or creates a new array if empty
#func add(animal: Animal, location: Vector2):
	#if locContents.has(location):
		#locContents[location].append(animal)
	#else:
		#locContents[location] = [animal]
		#
## removes an object from the location list (should it delete the array if empty?)
#func remove(animal: Animal, location: Vector2):
	#assert(locContents.has(location), "No Object in location")
	#locContents[location].erase(animal)
	#if locContents[location].isEmpty() :
		#locContents[location] = null
#
## getter		 
#func getLoc(location : Vector2):
	#return locContents[location]		
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


## Adds the given animal at the given location.
func add_animal(animal: Animal, location: Vector2):
	animal_container.add_child(animal)
	#add(animal, location)
	animal.position = location
