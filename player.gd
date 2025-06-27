extends Node2D
class_name Player

@export var movement_speed : float = .1
var movement_velocity : Vector2

func _process(delta: float) -> void:
	movement_velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		movement_velocity.x = -movement_speed
	elif Input.is_action_pressed("right"):
		movement_velocity.x = +movement_speed
	else :
		movement_velocity.x = 0
	
	if Input.is_action_pressed("down"):
		movement_velocity.y = movement_speed
	elif Input.is_action_pressed("up"):
		movement_velocity.y = -movement_speed
	else :
		movement_velocity.y = 0
		
	if movement_velocity != Vector2.ZERO:
		position += movement_velocity
