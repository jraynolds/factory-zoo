extends CanvasLayer
## Class for an interaction popup for things like "pick up 3 berries"

@export var label : Label

func set_readout(readout: String):
	label.text = readout
	visible = true


func hide_readout():
	visible = false
