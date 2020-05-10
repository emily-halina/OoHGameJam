extends TextureRect



var ID
var inventory
var image_path
var dimensions
var flavour_text
var sanity
var originNode: Array
var dragTile: Array
var OWOffset: Vector2
var drag: bool = false

#constructor for items
func _init(item_id):
	var properties = gv.ITEMS[item_id]
	ID = item_id
	image_path = properties["icon"]
	dimensions = properties["shape"]
	flavour_text = properties["flavour"]
	sanity = properties["comfort"]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var image = load(image_path)
	set_texture(image)
	set_scale(Vector2(1,1))
	pass # Replace with function body.

func startHover(selectedTile: Array, mouseCoords: Vector2):
	drag = true
	dragTile = [0,0]
	dragTile[0] = selectedTile[0]-originNode[0]
	dragTile[1] = selectedTile[1]-originNode[1]
	OWOffset = get_position()-mouseCoords-get_parent().get_position()
	
	
	
	gv.focusedItem = self

	#rearrange to be first in view
	
	print(get_parent())

func default_position():
	
	#set_position(Vector2(inventory.get_position().x+originNode[0]*inventory.inventory_width/inventory.tile_width,inventory.get_position().y+originNode[1]*inventory.inventory_height/inventory.tile_height))
	set_position(Vector2(originNode[1]*inventory.inventory_width/inventory.tile_width,originNode[0]*inventory.inventory_height/inventory.tile_height))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drag:
		var new_position = get_global_mouse_position()
		new_position+=OWOffset
		set_position(new_position)
		
		#check if mouse button was released when an item is selected

