extends RigidBody2D

@export var max_speed: float = 10
@export var acc: float = 10
@export var dec: float = 10
@export var jump_height: float = 10
@export var grav: float = 100
@export var offset: float = 200
@export var flip_timer: float = 1

var move: int = 0
var scale_y
var grounded = true
var flipped = 10
var pic_flipped = false

enum {CLOUD, GRAVITY}


var cloud = preload("res://Presets/Abilities/cloud.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	scale_y = scale.y


func _integrate_forces(state):
	if max_speed > abs(linear_velocity.x):
		linear_velocity.x = max_speed * move

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flipped + delta >= flip_timer and pic_flipped:
		scale.y = 1
		pic_flipped = false
	
	
	if flipped < flip_timer:
		flipped += delta
	
	grounded = $RayCast2D.is_colliding()
		
	apply_move(delta)
	

	if Input.is_action_just_pressed("dev"):
		cast_ability(GRAVITY)
		
	apply_gravity(delta)
	jump(delta)

func apply_move(delta):
	if Input.is_action_pressed("Left"):
		move = -1
	elif Input.is_action_pressed("Right"):
		move = 1
	else:
		move = 0
		
	apply_force(Vector2.RIGHT * move * acc * delta)

func jump(delta):
	if Input.is_action_pressed("Jump") and grounded:
		if flipped < flip_timer:
			if linear_velocity.y < 0:
				linear_velocity.y = 0
			apply_central_impulse(Vector2(0,1) * jump_height * delta)
		else:
			if linear_velocity.y > 0:
				linear_velocity.y = 0
			apply_central_impulse(Vector2(0, -1) * jump_height * delta)

func apply_gravity(delta):
	if not grounded:
		if flipped < flip_timer:
			apply_central_impulse(Vector2.UP * grav * delta)
		else:
			apply_central_impulse(Vector2.DOWN * grav * delta)
			
func cast_ability(abilty):
	match abilty:
		CLOUD:
			spawn(cloud, position + Vector2.DOWN * offset)
		GRAVITY:
			flipped = 0
			scale.y = -1
			pic_flipped = true

func spawn(abilty, pos):
	var a = abilty.instantiate()
	a.position = pos
	get_parent().add_child(a)


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):	
	if body.is_in_group("Spikes"):
		pass  # DIEING HAPPENS HERE
