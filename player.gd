extends CharacterBody2D
class_name Player
## Class for the player model.

@export var inventory : Inventory
@export var movement_speed : float = .1
var interactable_objects : Array ## The list of the objects our player can interact with.
var interactable_object : Object : ## The highest priority interactable object for our player.
	get :
		return interactable_objects[0] if !interactable_objects.is_empty() else null ## Return null if there's no interactables.


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
	
	## only works with one item right now
	if Input.is_action_just_pressed("pickup"):
		for object in interactable_objects :
			inventory.add_item(object)
			#object.queue_free() ## is this correct?
			#object.setvisible(false) for when inventory uses objects
			
	if Input.is_action_just_pressed("use"):
		inventory.remove_item()
		
			
func _physics_process(delta: float) -> void:
	move_and_slide()


func add_interactable_object(object):
	if object not in interactable_objects:
		interactable_objects.append(object)	
	InteractionReadout.set_readout('Press "E" to pick up Bergy (1)') ## needs to change text based on object


func remove_interactable_object(object):
	interactable_objects.erase(object)
	if not interactable_object:
		InteractionReadout.hide_readout()
