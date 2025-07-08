extends RigidBody2D
class_name Entity
## Base class for an Entity, a movable thing on the map.

@export var sprite : Sprite2D ## The sprite for this Entity.
@export var collision_shape : CollisionShape2D ## The collision shape for this Entity.

@export var spawning_component : Spawning ## The spawning component for this Entity.
@export var interaction_component : Interaction ## The interactivity component for this Entity.
@export var description : String
@export var title : String
var icon : Sprite2D :
	get: return sprite
