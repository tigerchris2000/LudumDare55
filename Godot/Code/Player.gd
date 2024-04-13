extends RigidBody2D

@export var max_speed: float = 10
@export var acc: float = 10
@export var dec: float = 10
@export var jump_height: float = 10

var move: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Dev_Add"):
		gravity_scale += 0.1
		print(gravity_scale)
		# max_speed += 10
		# print(max_speed)
		# linear_damp += 0.5
		# print(linear_damp)
	if Input.is_action_pressed("Dev_Sub"):
		gravity_scale -= 0.1
		print(gravity_scale)
		# max_speed -= 10
		# print(max_speed)
		# linear_damp -= 0.5
		# print(linear_damp)
		
	if Input.is_action_pressed("Left"):
		move = -1
	elif Input.is_action_pressed("Right"):
		move = 1
	else:
		move = 0

	if Input.is_action_pressed("Jump") and is_grounded():
		linear_velocity.y = 0
		apply_force(Vector2.UP * jump_height)
		
	apply_force(Vector2.RIGHT * move * acc * delta)
	if max_speed > abs(linear_velocity.x):
		linear_velocity.x = max_speed * move
		
func is_grounded() -> bool:
		return true
