extends HBoxContainer
class_name Inventory

@export var items_container : Node2D
#var items : Array[Entity] :
	#get :
		#var out : Array[Entity] = []
		#for child in items_container.get_children():
			#var item = child as Item ## We only want Items.
			#if item:
				#out.append(item)
		#return out
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
	# Initialize the ItemRegistry, which is a small database that contains data about each item in your inventory.
	#item_registry = ItemRegistry.new()
	item_buttons[0].button.set_pressed_no_signal(true)
	
	# Create a list of item, name, description, and icons:
	#for item in items:
		#add_item_to_registry(
			#items.find(item),
			#item.title,
			#item.description,
			#item.icon
		#)
	#for item in items:
		#print(item.title)
	#for item in items:
		#item_registry[item] = 0 ## One day we'll figure out what we can do as a key(item)/value(???) pair. Surely.
	for i in range(100): ## Give us 100 inventory slots.
		item_list.append(null)

	# Create an inventory with the item information just configured
	#inventory_manager = InventoryManager.new(item_registry)
	
	# Add health potions
	#add_item_by_name("Health Potion", 99 + 50)
	#add_item(load("res://entities/bergy.tscn") as Entity, 10)
	# By default the stack capacity is 99 items. The line above added two stacks on the first two item slots: one of 99 potions and another of 50 potions.


### Add an Item to the list of potential Items.
#func add_item_to_registry(id: int, item_name: String, item_description: String, item_icon: Texture2D):
	#item_registry.add_item(id, item_name, item_description, item_icon)


### Add an Entity to the list of potential Items. We're doing our own inventory handling.
#func add_item_to_registry(item: Entity):
	#item_registry[item] = 0 ## One day we'll figure out what we can do as a key(item)/value(???) pair. Surely.


## Add an Item to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
## If you don't include an inventory index, then we'll find the first one and stack it.
func add_item(item: Entity, amount: int=1, index: int = get_first_open_slot(item, true)):
	print("Adding item " + str(item.title) + " with amount " + str(amount) + " at index " + str(index))
	#var matching_items : Array = items.filter(func(i): return typeof(i) == typeof(item)) ## Share the same type
	#assert(!matching_items.is_empty(), "No matching items for item type " + str(item) + "!")
	#var matching_item = matching_items[0]
	if item_list[index] != null:
		if item_list[index].item.title == item.title:
			item_list[index].amount += amount
	else :
		item_list[index] = InventoryItem.new(item, amount)
	item_buttons[index].set_item(item, amount)
	item.get_parent().remove_child(item)
	items_container.add_child(item)
	item.visible = false
	#return inventory_manager.add(items.find(item), amount)


### Add an Item with the given name to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
#func add_item_by_name(item_name: String, amount: int=1, index: int = get_open_slot()):
	#var matching_items : Array = items.filter(func(item): return item.title == item_name)
	#assert(!matching_items.is_empty(), "No matching items for item name " + item_name + "!")
	#var item = matching_items[0]
	#if len(item_list) < index + 1:
		#item_list.append([item, amount])
	#else :
		#item_list[index] = [item, amount]
	#item_buttons[index].set_item(item, amount)
	##return inventory_manager.add(items.find(item), amount)

##experimental func for testing behavior
#func remove():
	#var item = items.filter(func(item): return item.title == "Bergy")[0]
	#item_buttons[0].set_item(item, 0)


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
