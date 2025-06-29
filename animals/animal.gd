extends RigidBody2D
class_name Animal
## Base class for animals.

@export var movement_component : Movement ## The movement component for this animal.
@export var spawning_component : Spawning ## The spawning component for this animal.
@export var interaction_component : Interaction ## The interaction component for this animal.

@export var packed_animal : PackedScene ## The default scene for this animal.
