extends PanelContainer
class_name ItemButton

@export var button : Button

func set_item(item, amount: int):
	button.icon = item.icon
	button.text = "\n"+str(amount) if amount > 0 else ""
