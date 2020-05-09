extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cozy = false
export var speed = 300.0
var _velocity = Vector2.ZERO
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta: float)-> void:
	
	direction = get_direction()
	_velocity = calculate_move_velocity(direction)
	_velocity = move_and_slide(_velocity)
	return


func calculate_move_velocity(direction: Vector2)-> Vector2:
	return direction*speed


func get_direction()-> Vector2:
	return Vector2(Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"),
	Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up"))


func _on_ComfortSensor_area_entered(area):
	print("Entry")
	get_node("Sprite").set_modulate(Color(1,0,0))
	cozy = true


func _on_ComfortSensor_area_exited(area):
	get_node("Sprite").set_modulate(Color(0,0,1))
	cozy = false
