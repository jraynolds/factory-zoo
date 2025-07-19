extends HBoxContainer
class_name Inventory

@export var items_container : Node2D
var items : Array :
	get :
		var out : Array = []
		for child in items_container.get_children():
			var item = child as Item ## We only want Items.
			if item:
				out.append(item)
		return out
@export var item_buttons : Array[ItemButton]

#var item_registry : ItemRegistry
var item_registry : Dictionary ## It's our own implementation. What is the value? That's a secret.
#var inventory_manager : InventoryManager
var item_list : Array[Array] ## The items the player holds. The format is Array[Array[Entity item, int amount]]
var selected_item : int = 0

func _ready() -> void:
	# Initialize the ItemRegistry, which is a small database that contains data about each item in your inventory.
	#item_registry = ItemRegistry.new()
	
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
	for item in items:
		item_registry[item] = 0 ## One day we'll figure out what we can do as a key(item)/value(???) pair. Surely.

	# Create an inventory with the item information just configured
	#inventory_manager = InventoryManager.new(item_registry)
	
	# Add health potions
	#add_item_by_name("Health Potion", 99 + 50)
	add_item($"Items container/Bergy" as Entity, 10)
	# By default the stack capacity is 99 items. The line above added two stacks on the first two item slots: one of 99 potions and another of 50 potions.


### Add an Item to the list of potential Items.
#func add_item_to_registry(id: int, item_name: String, item_description: String, item_icon: Texture2D):
	#item_registry.add_item(id, item_name, item_description, item_icon)


## Add an Item to the list of potential Items. We're doing our own inventory handling.
func add_item_to_registry(item: Item):
	item_registry[item] = 0 ## One day we'll figure out what we can do as a key(item)/value(???) pair. Surely.


## Add an Item to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
func add_item(item: Entity, amount: int=1, index: int = selected_item):
	var matching_items : Array = items.filter(func(i): return typeof(i) == typeof(item)) ## Share the same type
	assert(!matching_items.is_empty(), "No matching items for item type " + str(item) + "!")
	var matching_item = matching_items[0]
	if len(item_list) < index + 1:
		item_list.append([item, amount])
	else :
		item_list[index] = [item, amount]
	item_buttons[index].set_item(item, amount)
	#return inventory_manager.add(items.find(item), amount)


## Add an Item with the given name to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
func add_item_by_name(item_name: String, amount: int=1, index: int = selected_item):
	var matching_items : Array = items.filter(func(item): return item.title == item_name)
	assert(!matching_items.is_empty(), "No matching items for item name " + item_name + "!")
	var item = matching_items[0]
	if len(item_list) < index + 1:
		item_list.append([item, amount])
	else :
		item_list[index] = [item, amount]
	item_buttons[index].set_item(item, amount)
	#return inventory_manager.add(items.find(item), amount)

#experimental func for testing behavior
func remove():
	var item = items.filter(func(item): return item.title == "Bergy")[0]
	item_buttons[0].set_item(item, 0)

func remove_item(amount: int=1, index: int = selected_item) -> bool:
	if len(item_list) < index+1:
		return false
	#var item_id = inventory_manager.get_slot_item_id(index)
	#var remainder = inventory_manager.remove_items_from_slot(item_id, index, 1)
	item_list[index][1] -= amount ## Reduce the item stack at that index.
	item_buttons[index].set_item(item_list[index][0], item_list[index][1])
	if item_list[index][1] <= 0:
		item_buttons[index].set_item(null, 0)
		item_list[index] = []
	return true

func use_selected_item(location):
	var item = item_list[selected_item][0]
	if remove_item():
		item.use(location)
