extends Node2D
## Class for Map logic and container for everything on it.

@export var entity_container : Node2D ## Container for all entities on this map.
var entities : Array[Entity] : ## Getter for all entities in the container.
	get :
		var out : Array[Entity] = []
		for child in entity_container.get_children():
			var entity = child as Entity
			if entity:
				out.append(entity)
		return out
var animals : Array[Animal] : ## Getter for all animals in the container.
	get :
		var out : Array[Animal] = []
		for child in entity_container.get_children():
			var animal = child as Animal ## We use the "as" cast to allow for animals that extend Animal, not just base class Animal
			if animal:
				out.append(animal)
		return out

## Adds the given Entity as a child of the entity container, at the given location.
func add_entity(entity, location: Vector2):
	if entity.get_parent():
		entity.get_parent().remove_child(entity)
	entity_container.add_child(entity)
	entity.position = location
	entity.visible = true
	#animals.append(animal)

## Returns an empty location next to the given location.
func get_random_empty_neighbor_location(location: Vector2):
	for direction in Movement.get_random_cardinal_directions():
		var test_location = Movement.get_location_from_movement(location, direction, 16)
		if !get_entity_at_location(test_location):
			return test_location
	return null

## Returns an Entity at the given location, if one exists.
func get_entity_at_location(location: Vector2) -> Entity:
	for entity in entities:
		if entity.position.distance_squared_to(location) < 2: ## It's OK if it's close.
			return entity
	return null
