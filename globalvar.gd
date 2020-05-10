extends Node2D

var hewo = 'world'
var focusedItem = null
var inventory_list = []
var comfort_radius = 500
#Store information about items here
const ITEMS = {
	
	#test item
	1:{
		"icon": "res://Sprites/RainbootBlock.png",
		"flavour": "Don't want wet socks",
		"comfort": 500,
		"shape": [[0,1],[1,1]],
		'overworld': 'rain_boots'
	},
	2:{
		"icon": "res://Sprites/CatClockBlock.png",
		"flavour": "meow",
		"comfort": 300,
		"shape": [[1,1,1]],
		'overworld': 'cat_clock'
	},
	3:{
		"icon": "res://m.png",
		"flavour": "very warm",
		"comfort": 100,
		"shape": [[1]],
		'overworld': 'blanket'
	},
	4:{
		"icon": "res://m.png",
		"flavour": 'mouse-y',
		"comfort": 1000,
		"shape":[[1]],
		'overworld':'mouse'
	},
	5:{
		"icon":"res://Sprites/GnomeBlock.png",
		"flavour":"i'm gnot a gnelf",
		"comfort":3000,
		"shape":[[1,1,1]],
		'overworld':'gnome'
	},
	"error":{
		"icon": "res://L.png",
		"shape": [[0,0,1],[1,1,1]]
	}	
	
}

var comfort_meter = 1000

var collected_items = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
