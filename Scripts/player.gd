extends KinematicBody2D



var cozy = false
export var speed = 300.0
var _velocity = Vector2.ZERO
var direction = Vector2.ZERO


onready var sprite = get_node('Sprite')
var animation = 'StaticFront'

onready var enemy = get_tree().get_root().find_node('Enemy', true, false)
onready var inventory = get_tree().get_root().find_node('InventoryManager')

# Called when the node enters the scene tree for the first time.
func _ready():
	# make player blue when not in comfort zone
	_on_ComfortSensor_area_exited(null)
	inventory = get_node("Camera2D/CanvasLayer/InventoryManager")
	if enemy != null:
		enemy.connect('contact', self, '_on_enemy_contact')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta: float)-> void:
	direction = get_direction()
	_velocity = calculate_move_velocity(direction)
	_velocity = move_and_slide(_velocity)
	animation = set_animation(direction)
	if not cozy:
		gv.comfort_meter -= 1
	else:
		gv.comfort_meter = 1000
	if gv.comfort_meter == 0:
		print('ur dead kid')


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

func set_animation(direction):
	var a = ''
	# if player is moving, play walk animation
	if direction != Vector2.ZERO:
		a += 'Walk'
		if direction.x == -1:
			a += 'Left'
		elif direction.x == 1:
			a += 'Right'
		if direction.y == 1:
			a += 'Front'
		elif direction.y == -1:
			a += 'Back'
	# if player stops, play static animation in correct direction
	else:
		# if the player is standing still, keep them facing the same way
		if animation[0] == 'S':
			a = animation
		else:
			a += 'Static'
			a += animation.right(4)
	sprite.play(a)
	return a

func _on_enemy_contact():
	inventory.drop_all()
	# here is where we will drop all the items if there are items in the player's inventory


func _on_House_area_entered(area):
	print('hey i am entered')
	get_tree().change_scene('res://Levels/House.tscn')
