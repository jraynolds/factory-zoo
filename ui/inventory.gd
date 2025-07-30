extends HBoxContainer
class_name Inventory

@export var items_container : Node2D
@export var item_buttons : Array[ItemButton]
@export var item_button_group : ButtonGroup

## Struct class to simplify inventory management.
class InventoryItem:
	var item: Entity
	var amount: int
	
	func _init(item: Entity, amount: int=1):
		self.item = item
		self.amount = amount

#var item_registry : ItemRegistry
var item_registry : Dictionary ## It's our own implementation. What is the value? That's a secret.
#var inventory_manager : InventoryManager
## The items the player holds. The format is Array[Array[Entity item, int amount]]
## We give the player 100 open slots.
var item_list : Array[InventoryItem] 
var selected_button : ItemButton : ## The selected button in the player's inventory.
	get :
		var pressed_button = item_button_group.get_pressed_button()
		if !pressed_button:
			return null
		return item_buttons.filter(func(item_button: ItemButton): return item_button.button == pressed_button)[0]
var selected_item : InventoryItem : ## The item (if any) in the selected button.
	get :
		return item_list[item_buttons.find(selected_button)]

func _ready() -> void:
	item_buttons[0].button.set_pressed_no_signal(true)
	for i in range(100): ## Give us 100 inventory slots.
		item_list.append(null)


## Add an Item to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
## If you don't include an inventory index, then we'll find the first one and stack it.
func add_item(item: Entity, amount: int=1, index: int = get_first_open_slot(item, true)):
	print("Adding item " + str(item.title) + " with amount " + str(amount) + " at index " + str(index))
	#var matching_items : Array = items.filter(func(i): return typeof(i) == typeof(item)) ## Share the same type
	#assert(!matching_items.is_empty(), "No matching items for item type " + str(item) + "!")
	#var matching_item = matching_items[0]
	var total = amount
	if item_list[index] != null:
		if item_list[index].item.title == item.title:
			total = item_list[index].amount + amount
			item_list[index].amount = total
	else :
		item_list[index] = InventoryItem.new(item, amount)
	item_buttons[index].set_item(item, total)
	item.get_parent().remove_child(item)
	items_container.add_child(item)
	item.visible = false
	#return inventory_manager.add(items.find(item), amount)


## Removes the given amount of an item at the given slot. By default, the selected button.
func remove_item(amount: int = 1, index: int = item_buttons.find(selected_button)):
	print("removing " + str(amount) + " copies of item at index " + str(index))
	if index == -1 or item_list[index] == null or item_list[index].item == null:
		return ## No item to decrement!
	#print("We have an item to decrement.")
	#var item_id = inventory_manager.get_slot_item_id(index)
	#var remainder = inventory_manager.remove_items_from_slot(item_id, index, 1)
	item_list[index].amount -= amount ## Reduce the item stack at that index.
	if item_list[index].amount <= 0:
		item_buttons[index].set_item()
		item_list[index] = null
	else :
		item_buttons[index].set_item(item_list[index].item, item_list[index].amount)


## Returns the first empty index number in the item list for the given item. Finds the first matching item, if allowed by default.
func get_first_open_slot(item: Entity = null, allow_stacking: bool = true) -> int:
	for i in len(item_list):
		if allow_stacking and item:
			if item_list[i] != null and item_list[i].item.title == item.title:
				return i
		if item_list[i] == null:
			return i
	assert(false, "The inventory is full!")
	return -1


## Uses the player's selected item at the given screen location.
func use_selected_item(location: Vector2):
	selected_item.item.use(location)
	remove_item()
