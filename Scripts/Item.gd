extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var itemID = 1
# Called when the node enters the scene tree for the first time.
func _ready():

	get_node('Sprite').play(gv.ITEMS[itemID]['overworld'])




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
