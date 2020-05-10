extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var InventoryScript = preload("res://Scripts/Inventory.gd")
var activeInventories = []
var inventory_open: bool = false
var Inventory
var ItemGrab
var Item
var itemInRange: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory = get_node("Inventory")
	ItemGrab = get_node("RandomDrop")
	pass # Replace with function body.

func add_inventory(inventory):
	activeInventories.append(inventory)
	add_child(inventory)

func checkItem():
	Inventory.check_if_place()
	ItemGrab.check_if_place()
	
	gv.focusedItem.default_position()	
	gv.focusedItem.drag = false
	gv.focusedItem = null
	
	if ItemGrab.isEmptyGrid():
		togglePickup(false)
		Item.queue_free()
	
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if(inventory_open):
			Inventory.hide()
			ItemGrab.hide()
		else:
			Inventory.show()
			if itemInRange:
				ItemGrab.show()
		inventory_open = !inventory_open

func togglePickup(state: bool):
	if state:
		ItemGrab.resize_inventory_and_add(4,4,Item.itemID)
		if inventory_open:
			ItemGrab.show()
	else:
		if inventory_open:
			ItemGrab.hide()
	itemInRange = state

func _on_ItemRange_body_exited(body):
	print("Exit Item")
	Item = null
	togglePickup(false)


func _on_ItemRange_body_entered(body):
	print("Enter Item")
	Item = body
	togglePickup(true)
