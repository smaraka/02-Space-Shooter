extends KinematicBody2D

var VP := Vector2.ZERO
var velocity := Vector2.ZERO
var acceleration := 0.1
var rotation_accel := 0.075
var max_speed := 10
var spdIncr := 8

var push := 400
var reflect := 2
var respawn_state := 0
var Bullet = preload("res://Bullet/Bullet.tscn")
var Bullets = null

var Explosion = preload("res://Explosion/Explosion_ship.tscn")
var Explosions = null


func _ready():
	VP = get_viewport().size
	#get_node("CollisionShape2D").disabled = true
	respawn_state == 0
func _physics_process(_delta):
	
	position.x = wrapf(position.x,0,VP.x)
	position.y = wrapf(position.y,0,VP.y)
	#rotation += get_rotation()*rotation_accel
	velocity = get_input()
	velocity = velocity.normalized() * clamp(velocity.length(),0,max_speed)
	var collision = move_and_collide(velocity,false)
	if collision != null and collision.collider is RigidBody2D:
		collision.collider.apply_central_impulse(-collision.normal * push)
		velocity = velocity + collision.normal*reflect
		if collision.collider.has_method("die"):
			collision.collider.die()
		die()
	elif collision != null:
		die()

	if Input.is_action_just_released("shoot"):
		if Bullets == null:
			Bullets = get_node_or_null("/root/Game/Bullets")
		if Bullets != null:
			for n in 5:
				var bullet = Bullet.instance()
				bullet.position = position + Vector2(0,-20).rotated(rotation)
				bullet.position.x += n
				bullet.rotation = rotation
				Bullets.add_child(bullet)

func die():
	if Global.has_method("update_health"):
		Global.update_health(-10)
	if Explosions == null:
		Explosions = get_node_or_null("/root/Game/Explosions")
	if Explosions != null:
		var explosion = Explosion.instance()
		explosion.position = position
		Explosions.add_child(explosion)
	queue_free()

func get_input():
	var toReturn := Vector2.ZERO
	if Input.is_action_pressed("forward"):
		toReturn.y -= spdIncr
		

	if Input.is_action_pressed("back"):
		toReturn.y += spdIncr

	if Input.is_action_pressed("right"):
		toReturn.x += spdIncr

	if Input.is_action_pressed("left"):
		toReturn.x -= spdIncr

	return toReturn
	
func get_rotation():
	var toReturn := 0.0
	if Input.is_action_pressed("right"):
		toReturn += 1.0
	if Input.is_action_pressed("left"):
		toReturn -= 1.0
	return toReturn


func _on_Timer_timeout():
	pass
