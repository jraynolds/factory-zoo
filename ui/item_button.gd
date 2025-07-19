extends PanelContainer
class_name ItemButton

@export var button : Button

### Runs when it enters the scene tree. 
#func _process(delta: float) -> void:
	#button.text = ""

## Sets the item this slot holds. By default, no item with no amount.
func set_item(item: Entity=null, amount: int=0):
	if !item:
		button.icon = null
		button.text = ""
	else :
		button.icon = item.sprite.texture
		button.text = "\n"+str(amount) if amount > 1 else ""
