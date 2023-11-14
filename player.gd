extends CharacterBody2D

var speed: int = 200
var jump_force: int = 600
var gravity: int = 800
var vel: Vector2 = Vector2()
var sprite: Sprite2D

var ground_ray_left: RayCast2D
var ground_ray_right: RayCast2D

func _ready():
	sprite = $Sprite2D
	ground_ray_left = $GroundRayLeft
	ground_ray_right = $GroundRayRight

func _process(delta):
	vel.x = 0

	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		vel.y = -jump_force

	vel.y += gravity * delta

	# Check if the left or right raycast is hitting the ground
	if ground_ray_left.is_colliding() or ground_ray_right.is_colliding():
		# Move and collide without stopping on slopes
		var collision = move_and_collide(vel)
		if collision:
			vel = collision.remainder
	else:
		# Move and collide without stopping on slopes
		var collision = move_and_collide(vel)
		if collision:
			vel = collision.remainder

	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false

# h turn movement not inpmplimented

