extends StaticBody2D

# Declare member variables here. Examples:
var boots = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if boots:
		get_node("PuddleCollision").set_disabled(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _on_boots_equipped():
	#get_node("PuddleCollision").set_disabled(true)
