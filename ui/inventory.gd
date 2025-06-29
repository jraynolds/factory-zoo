extends HBoxContainer
class_name Inventory

@export var items_container : Node2D
var items : Array[Item] :
	get :
		var out : Array[Item] = []
		for child in items_container.get_children():
			var item = child as Item
			if item:
				out.append(item)
		return out
@export var item_buttons : Array[ItemButton]

var item_registry : ItemRegistry
var inventory_manager : InventoryManager
var item_list : Array[Array]

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

	# Create an inventory with the item information just configured
	inventory_manager = InventoryManager.new(item_registry)
	
	# Add health potions
	add_item("Health Potion", 99 + 50)
	# By default the stack capacity is 99 items. The line above added two stacks on the first two item slots: one of 99 potions and another of 50 potions.


## Add an Item to the list of potential Items.
func add_item_to_registry(id: int, item_name: String, item_description: String, item_icon: Texture2D):
	item_registry.add_item(id, item_name, item_description, item_icon)


## Add an Item to the player's inventory with the given amount (by default, 1) at the given inventory index (by default, 0).
## Returns an ExcessItems object.
func add_item(item_name: String, amount: int=1, index: int = 0) -> ExcessItems:
	var item : Item = items.filter(func(item): return item.title == item_name)[0]
	item_buttons[index].set_item(item, amount)
	assert(item)
	return inventory_manager.add(items.find(item), amount)
