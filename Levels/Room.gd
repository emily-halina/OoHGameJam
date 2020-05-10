extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_House_area_shape_entered(area_id, area, area_shape, self_shape):
	pass


func _on_House_body_entered(body):
	get_tree().change_scene('res://Levels/House.tscn')
