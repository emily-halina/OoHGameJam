extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	gs.get_node('room_song').stop()
	gs.get_node('forest_song').play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		gs.get_node('forest_song').stop()
		get_tree().change_scene('res://Levels/TitleScreen.tscn')
		
