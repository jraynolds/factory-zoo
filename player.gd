extends CharacterBody2D
class_name Player
## Class for the player model.

@export var movement_speed : float = .1

func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x = -movement_speed
	elif Input.is_action_pressed("right"):
		velocity.x = +movement_speed
	else :
		velocity.x = 0
	
	if Input.is_action_pressed("down"):
		velocity.y = movement_speed
	elif Input.is_action_pressed("up"):
		velocity.y = -movement_speed
	else :
		velocity.y = 0


func _physics_process(delta: float) -> void:
	move_and_slide()
