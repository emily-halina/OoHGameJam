extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tint_color

# Called when the node enters the scene tree for the first time.
func _ready():
	tint_color = Color(1,0,0,0.25)
	pass # Replace with function body.

func _draw():
	draw_circle(Vector2(0,0),get_node("Area2D/CollisionShape2D").shape.radius, tint_color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
