extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng
var InventoryScript = preload("res://Scripts/Inventory.gd")
var ItemScript = preload("res://Entities/Item.tscn")
var flavour_display
var activeInventories = []
var inventory_open: bool = false
var Inventory
var ItemGrab
var Item
var itemList = []
var itemInRange: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	Inventory = get_node("Inventory")
	ItemGrab = get_node("RandomDrop")
	flavour_display = get_node("Flavour")
	ItemGrab.fillable = false
	pass # Replace with function body.

func add_inventory(inventory):
	activeInventories.append(inventory)
	add_child(inventory)

func checkItem():
	var c_Item = Item
	var added = false
	added = Inventory.check_if_place()
	
	if(!added):
		added = ItemGrab.check_if_place()
	else:
		c_Item.queue_free()
		remove_item_from_list(Item)
	
	if(!added and !itemInRange):
		dropItem(gv.focusedItem)
	
	gv.focusedItem.default_position()	
	gv.focusedItem.drag = false
	gv.focusedItem = null
	
	if itemInRange and ItemGrab.isEmptyGrid():
		togglePickup(false)
	
	pass

func drop_all():
	var list_length = Inventory.inventory_list.size()
	for x in range(list_length):
		dropItem(Inventory.inventory_list[list_length-1-x])


func dropItem(drop):
	drop.inventory.remove_item_object(drop)
	var player = get_parent().get_parent().get_parent()
	var newItem = ItemScript.instance()
	print(player)
	print(player.get_parent())
	newItem.itemID = drop.ID
	player.get_parent().add_child(newItem)
	var offset = Vector2(rng.randf_range(-5,5),rng.randf_range(-5,5))
	newItem.set_position(player.get_position()+offset)
	

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if(inventory_open):
			Inventory.hide()
			ItemGrab.hide()
			flavour_display.hide()
		else:
			Inventory.show()
			if itemInRange:
				flavour_display.show()
				ItemGrab.show()
		inventory_open = !inventory_open
	
	#Debug dropall implementation
	if Input.is_action_just_pressed("ui_cancel"):
		drop_all()

func togglePickup(state: bool):
	if state:
		ItemGrab.resize_inventory_and_add(4,4,Item.itemID)
		update_flavour_text()
		if inventory_open:
			ItemGrab.show()
			flavour_display.show()
	else:
		if inventory_open:
			ItemGrab.hide()
			flavour_display.hide()
	itemInRange = state

func _on_ItemRange_body_exited(body):
	remove_item_from_list(body)
	

func remove_item_from_list(body):
	var pos = itemList.find(body)
	itemList.remove(pos)
	if(itemList.size()<=0):
		Item = null
		togglePickup(false)
	else: if(pos == 0):
		Item = itemList[0]
		ItemGrab.resize_inventory_and_add(4,4,Item.itemID)
		update_flavour_text()

func update_flavour_text():
	flavour_display.set_text(getTooltip(Item.itemID))

func getTooltip(var index)->String:
	var ft = gv.ITEMS[index]["flavour"]
	var cft = gv.ITEMS[index]["comfort"]
	return ft+"\n"+"Provides: "+str(cft)+" comfort"

func _on_ItemRange_body_entered(body):
	print("Enter Item")
	itemList.append(body)
	if(itemList.find(body)==0):
		Item = body
	togglePickup(true)
