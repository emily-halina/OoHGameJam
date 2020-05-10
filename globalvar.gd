extends Node2D

var hewo = 'world'
var focusedItem = null
var inventory_list = []
#Store information about items here
const ITEMS = {
	
	#test item
	1:{
		"icon": "res://L.png",
		"flavour": "take it",
		"comfort": 5,
		"shape": [[0,0,1],[1,1,1]],
		'overworld': 'rain_boots'
	},
	2:{
		"icon": "res://i.png",
		"flavour": "best tetromino",
		"comfort": 3,
		"shape": [[1,1,1]],
		'overworld': 'cat_clock'
	},
	3:{
		"icon": "res://m.png",
		"flavour": "dense",
		"comfort": 1,
		"shape": [[1]],
		'overworld': 'blanket'
	},
	
	"error":{
		"icon": "res://L.png",
		"shape": [[0,0,1],[1,1,1]]
	}	
	
}

var comfort_meter = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
