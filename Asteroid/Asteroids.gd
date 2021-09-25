extends Node2D

var positions = [
	Vector2(100,100)
	,Vector2(1000,150)
	,Vector2(800,600)
	,Vector2(200,550)
]
var Asteroid = preload("res://Asteroid/Asteroid.tscn")
var count = 0
var target = 1
var respawn = 1500

func _ready():
	randomize()

func _physics_process(_delta):
	if get_child_count() == 0:
		add_asteroid()
	count += 1
	if count > target:
		add_asteroid()

func add_asteroid():
	var asteroid = Asteroid.instance()
	asteroid.position = positions[randi() % positions.size()] + Vector2(randf()*100, randf()*100).rotated(randf()*2*PI)
	asteroid.linear_velocity = Vector2(30,0).rotated(randf()*2*PI)
	add_child(asteroid)
	target = randi() % respawn
	count = 0
