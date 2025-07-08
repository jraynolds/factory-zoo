extends RigidBody2D
class_name Entity
## Base class for an Entity, a movable thing on the map.

@export var sprite : Sprite2D ## The sprite for this Entity.
@export var collision_shape : CollisionShape2D ## The collision shape for this Entity.

@export var spawning_component : Spawning ## The spawning component for this Entity.
@export var interaction_component : Interaction ## The interactivity component for this Entity.
@export var title : String ## The title of this Entity.
@export_multiline var description : String ## A longer description for this Entity.
var icon : Texture2D : ## The texture we display for this Entity.
	get: return sprite.texture
