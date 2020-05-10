extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tint_color
var shape

# Called when the node enters the scene tree for the first time.
func _ready():
	tint_color = Color(1,0,0,0.25)

	shape = get_node("Area2D/CollisionShape2D").get_shape()
	updateRadius()
	pass # Replace with function body.

func _draw():
	draw_circle(Vector2(0,0),shape.get_radius(), tint_color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func updateRadius():
	shape.set_radius(gv.comfort_radius)
	update()
	print("radius is ", get_node("Area2D/CollisionShape2D").shape.radius)

func _on_Area2D_body_entered(body):
	print("expand area")
	gv.comfort_radius+=body.comfort
	updateRadius()
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	print("contract area")
	gv.comfort_radius-=body.comfort
	updateRadius()
	pass # Replace with function body.
