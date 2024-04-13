extends RigidBody2D

@export var max_speed: float = 10
@export var acc: float = 10
@export var dec: float = 10
@export var jump_height: float = 10
@export var grav: float = 100
@export var offset: float = 200

var move: int = 0
var grounded = true

enum {CLOUD}

var cloud = preload("res://Presets/Abilities/cloud.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _integrate_forces(state):
	if grounded:
		linear_velocity.y = 0
	if max_speed > abs(linear_velocity.x):
		linear_velocity.x = max_speed * move

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Engine.get_frames_per_second())
	grounded = $RayCast2D.is_colliding()
		
	if Input.is_action_pressed("Left"):
		move = -1
	elif Input.is_action_pressed("Right"):
		move = 1
	else:
		move = 0

	apply_force(Vector2.RIGHT * move * acc * delta)
	
	if Input.is_action_pressed("Jump") and grounded:
		grounded = false
		apply_central_impulse(Vector2(0,-1) * jump_height)
		
	if Input.is_action_just_pressed("dev"):
		cast_ability(CLOUD)
		
	if not grounded:
		apply_central_impulse(Vector2.DOWN * grav * delta)

func cast_ability(abilty):
	match abilty:
		CLOUD:
			spawn(cloud, position + Vector2.DOWN * offset)

func spawn(abilty, pos):
	var a = abilty.instantiate()
	a.position = pos
	get_parent().add_child(a)
