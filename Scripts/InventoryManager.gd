extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var InventoryScript = preload("res://Scripts/Inventory.gd")
var activeInventories = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_inventory(inventory):
	activeInventories.append(inventory)
	add_child(inventory)

func checkItem():
	get_node("Inventory").check_if_place()
	get_node("RandomDrop").check_if_place()
	
	gv.focusedItem.default_position()	
	gv.focusedItem.drag = false
	gv.focusedItem = null
	pass
