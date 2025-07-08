extends Area2D
class_name Interaction
## Class for an entity's interactions.

@export var enabled : bool = false ## Whether we care about interactivity.

func _on_body_entered(body: Node2D):
	if !enabled:
		return
	var player = body as Player
	if player:
		player.add_interactable_object(get_parent())


func _on_body_exited(body: Node2D):
	if !enabled:
		return
	var player = body as Player
	if player:
		player.remove_interactable_object(get_parent())
