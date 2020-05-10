extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	gs.get_node('room_song').play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		gv.comfort_meter = 1000
		get_tree().change_scene('res://Levels/Room.tscn')
