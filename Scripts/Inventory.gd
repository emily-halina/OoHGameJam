extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fillable: bool = true
var inventory_width =400
var inventory_height =400
var tile_width = 4
var tile_height = 4
var inventory_tiles
var inventory_list =[]
var ItemScript = preload("res://Scripts/InventoryTile.gd")

# Called when the node enters the scene tree for the first time.

func _ready():
	hide()
	print(rect_size)
	#get_node("InventoryBackground").set_size(inventory_width,inventory_height)
	inventory_tiles = create_array_2d(tile_width,tile_height)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_released("inventory_select"):
			print("released")
			if(gv.focusedItem != null):
				get_parent().checkItem()
				
func isEmptyGrid()->bool:
	for x in range(tile_width):
		for y in range(tile_height):
			if(inventory_tiles[x][y] != -1):
				return false
	
	return true

	
func check_if_place():
	var sametile: bool = gv.focusedItem.inventory == self
					
				#get slot inside of the item
	var location = get_inventory_slot_selected(get_global_mouse_position())
	if(location[0]!=-1):
					
					#Check and reassignment
		if(sametile and check_valid_placement(location, inventory_list.find(gv.focusedItem)) or check_valid_placement(location,-1)):
			gv.focusedItem.inventory.remove_item(gv.focusedItem.inventory.inventory_list.find(gv.focusedItem))
			add_item([location[0]-gv.focusedItem.dragTile[0],location[1]-gv.focusedItem.dragTile[1]],gv.focusedItem)
			if(!sametile):
				return true
	return false			

func check_valid_placement(selectedTile: Array, okIndex)-> bool:
	var checkItem = gv.focusedItem
	var i_start = [selectedTile[0]-checkItem.dragTile[0],selectedTile[1]-checkItem.dragTile[1]]
	
	var shape = checkItem.dimensions
	
	#Modified x and y for checking grid
	var c_x
	var c_y
	
	#check if the shape fits correctly
	
	if !fillable:
		return false
	
	for x in range(shape.size()):
		for y in range(shape[0].size()):
			c_x = x+i_start[1]
			c_y = y+i_start[0]
	
			if(c_x<0 or c_x>=tile_width or c_y<0 or c_y>=tile_height):
				return false
			if(shape[x][y] == 1 and inventory_tiles[c_y][c_x] != -1 and inventory_tiles[c_y][c_x] != okIndex):
				return false
	return true
	
func _on_InventoryManager_gui_input(event):
	# check if mouse button was pressed on the inventories
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var selected_index = get_inventory_slot_selected(get_global_mouse_position())
		print(selected_index)
		if inventory_tiles[selected_index[0]][selected_index[1]] != -1:
			var selected_item = inventory_list[inventory_tiles[selected_index[0]][selected_index[1]]]
			selected_item.startHover(selected_index,event.position)
	
#method creates an empty array used for inventory
func create_array_2d(width,height):
	var a = []
	
	for x in range(width):
		a.append([])
		a[x].resize(height)
		
		for y in range(width):
			a[x][y] = -1
			
	return a

#Method to add an item to the inventory
func add_item(inventorySlot: Array, item):
	item.originNode = inventorySlot
	inventory_list.append(item)
	var index = inventory_list.size()-1
	
	#Adds to the hierarchy and set position
	add_child_below_node(get_node("InventoryBackground"),item,false)
	item.inventory = self
	item.default_position()
	
	#Sets the grid indices
	var shape = item.dimensions
	
	for x in range(shape.size()):
		for y in range(shape[0].size()):
			if shape[x][y] != 0:
				inventory_tiles[inventorySlot[0]+y][inventorySlot[1]+x] = index

#Method to remove an item with a specific index
func remove_item(listslot: int):
	
	#Remove Child
	
	#Slot shenanigans
	var removed_item = inventory_list[listslot]
	inventory_list.remove(listslot)
	for x in range(tile_width):
		for y in range(tile_height):
			if inventory_tiles[x][y] == listslot:
				inventory_tiles[x][y] = -1
			if inventory_tiles[x][y] >listslot:
				inventory_tiles[x][y]-=1
	removed_item.inventory.remove_child(removed_item)

#Method to remove an item with a specific object
func remove_item_object(obj):
	
	#Remove Child
	var listslot = inventory_list.find(obj)
	var removed_item = obj
	inventory_list.remove(listslot)
	for x in range(tile_width):
		for y in range(tile_height):
			if inventory_tiles[x][y] == listslot:
				inventory_tiles[x][y] = -1
			if inventory_tiles[x][y] >listslot:
				inventory_tiles[x][y]-=1
	removed_item.inventory.remove_child(removed_item)


#Method to return the proper value in the inventory grid for a corresponding mouse click, returns -1 if not in area
func get_inventory_slot_selected(mousePosition: Vector2):
	
	var index: Array
	var main_inventory_coords = mousePosition
	main_inventory_coords-=get_global_position()
	print("mouse coords")
	print(mousePosition)
	print(get_global_mouse_position())
	print(get_global_position())
	print(main_inventory_coords)

	#check if inside the bounds of the main inventory
	
	if main_inventory_coords.x>=0 and main_inventory_coords.x<=inventory_width and main_inventory_coords.y>=0 and main_inventory_coords.y<=inventory_height:
		index = get_inventory_index(main_inventory_coords)
		return index
		#generate indexes for the inventory
	
	return [-1,-1]
	
#Method that converts inventory coordinates to array indexes
func get_inventory_index(inventoryPosition: Vector2):
	var x_index: int = int(inventoryPosition.x/inventory_width*tile_width)
	var y_index: int = int(inventoryPosition.y/inventory_height*tile_height)
	return [y_index,x_index]

func resize_inventory(columns,rows):
	tile_width = columns
	tile_height = rows
	inventory_width = columns*100
	inventory_height = rows*100
	get_node("InventoryBackground").set_size(Vector2(inventory_width,inventory_height))
	
	while inventory_list.size()>0:
		remove_item(0)
	
	inventory_tiles = create_array_2d(tile_width,tile_height)

func resize_inventory_and_add(columns,rows,ItemID):
	tile_width = columns
	tile_height = rows
	inventory_width = columns*100
	inventory_height = rows*100
	get_node("InventoryBackground").set_size(Vector2(inventory_width,inventory_height))
	
	while inventory_list.size()>0:
		remove_item(0)
	
	inventory_tiles = create_array_2d(tile_width,tile_height)
	var add = ItemScript.new(ItemID)
	add_item([0,0],add)


func _on_Inventory_gui_input(event):
	pass # Replace with function body.
