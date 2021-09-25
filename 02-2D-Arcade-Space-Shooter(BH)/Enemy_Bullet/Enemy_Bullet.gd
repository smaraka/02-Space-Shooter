extends Area2D

var VP := Vector2.ZERO
var velocity := Vector2(0,-10)
const speed := 100 


var Explosions = null
var Explosion = preload("res://Explosion/Explosion.tscn")

func _ready():
	VP = get_viewport().size

func _physics_process(_delta):
	position += transform.x * speed * _delta

func _on_Timer_timeout():
	queue_free()
	

func die():
	if Explosions == null:
		Explosions = get_node_or_null("/root/Game/Explosions")
	if Explosions != null:
		var explosion = Explosion.instance()
		explosion.position = position
		Explosions.add_child(explosion)
	queue_free()

func _on_Bullet_body_entered(body):
	if Explosions == null:
		Explosions = get_node_or_null("/root/Game/Explosions")
	if Explosions != null:
		var explosion = Explosion.instance()
		explosion.position = position
		Explosions.add_child(explosion)
	if body.has_method("die"):
		body.die()
	queue_free()




func _on_Enemy_Bullet_area_shape_entered(area_id, area, area_shape, local_shape):
	queue_free()
