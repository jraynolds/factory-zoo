extends HBoxContainer
class_name Inventory

@export var items_container : Node2D
var items : Array :
	get :
		var out : Array = []
		for child in items_container.get_children():
			#var item = child as Item
			#if item:
			out.append(child)
		return out
@export var item_buttons : Array[ItemButton]

var item_registry : ItemRegistry
var inventory_manager : InventoryManager
var item_list : Array[Array]
var selected_item : int = 0

func _ready() -> void:
	# Initialize the ItemRegistry, which is a small database that contains data about each item in your inventory.
	item_registry = ItemRegistry.new()
	
	# Create a list of item, name, description, and icons:
	for item in items:
		add_item_to_registry(
			items.find(item),
			item.title,
			item.description,
			item.icon
		)
	for item in items:
		print(item.title)

	# Create an inventory with the item information just configured
	inventory_manager = InventoryManager.new(item_registry)
	
	# Add health potions
	add_item("Health Potion", 99 + 50)
	add_item("Bergy", 10)
	# By default the stack capacity is 99 items. The line above added two stacks on the first two item slots: one of 99 potions and another of 50 potions.


## Add an Item to the list of potential Items.
func add_item_to_registry(id: int, item_name: String, item_description: String, item_icon: Texture2D):
	item_registry.add_item(id, item_name, item_description, item_icon)


## Add an Item to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
## Returns an ExcessItems object.
func add_item(item_name: String, amount: int=1, index: int = selected_item) -> ExcessItems:
	var matching_items : Array = items.filter(func(item): return item.title == item_name)
	assert(!matching_items.is_empty(), "No matching items for item name " + item_name + "!")
	var item = items.filter(func(item): return item.title == item_name)[0]
	item_buttons[index].set_item(item, amount)
	assert(item)
	return inventory_manager.add(items.find(item), amount)

#experimental func for testing behavior
func remove():
	var item = items.filter(func(item): return item.title == "Bergy")[0]
	item_buttons[0].set_item(item, 0)

func remove_item(amount: int=1, index: int = selected_item):
	var item_id = inventory_manager.get_slot_item_id(index)
	var remainder = inventory_manager.remove_items_from_slot(item_id, index, 1)
	item_buttons[index].set_item(items[index], remainder)
	
