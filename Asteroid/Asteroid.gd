extends RigidBody2D

var screensize = Vector2.ZERO

var Asteroid_small = preload("res://Asteroid/Asteroid_small.tscn")
var Asteroids = null
var Explosions = null
var Explosion = preload("res://Explosion/Explosion.tscn")



func _ready():
	screensize = get_viewport().size

func _integrate_forces(state):
	var t = state.get_transform()
	t.origin.x = wrapf(t.origin.x,0,screensize.x)
	t.origin.y = wrapf(t.origin.y,0,screensize.y)
	state.set_transform(t)

func die():
	call_deferred("_create_children")

func _create_children():
	if Explosions == null:
		Explosions = get_node_or_null("/root/Game/Explosions")
	if Explosions != null:
		var explosion = Explosion.instance()
		explosion.position = position
		Explosions.add_child(explosion)
	if Asteroids == null:
		Asteroids = get_node_or_null("/root/Game/Asteroids")
	if Asteroids != null:
		var asteroid_small = Asteroid_small.instance()
		asteroid_small.position = position + Vector2(8,8)
		asteroid_small.apply_central_impulse(Vector2(30,30))
		Asteroids.add_child(asteroid_small)
		asteroid_small = Asteroid_small.instance()
		asteroid_small.position = position + Vector2(-8,-8)
		asteroid_small.apply_central_impulse(Vector2(-30,-30))
		Asteroids.add_child(asteroid_small)
	queue_free()
