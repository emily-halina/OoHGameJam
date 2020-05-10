extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 2.0
var direction = Vector2(1,0)
var _velocity = Vector2.ZERO
var collision = null

signal contact

func _ready():
	get_node('Patrol').start()

func vert_flip():
	# call this in the scene on the specific enemy to make it a verty-flip
	direction = Vector2(0,1)

func _physics_process(delta: float)-> void:
	_velocity = calculate_move_velocity(direction)
	collision = move_and_collide(_velocity)
	if collision != null:
		handle_collision(collision)

func calculate_move_velocity(direction: Vector2)-> Vector2:
	return direction*speed

func handle_collision(collision):
	emit_signal('contact')


func _on_Patrol_timeout():
	print('flip')
	direction = -direction
	print(direction)
