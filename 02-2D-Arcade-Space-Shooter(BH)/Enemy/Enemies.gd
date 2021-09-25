extends Node2D

var positions = [
	Vector2(200,200)
	,Vector2(912,200)
	,Vector2(912,400)
	,Vector2(200,400)
]

var Enemy = preload("res://Enemy/Enemy.tscn")
var num_enemies = 2
var respawning = false

func _ready():
	randomize()

func _physics_process(_delta):
	if (get_child_count()-1 < num_enemies) and (respawning):
		$Respawn.start()
		respawning = true

func add_enemy():
	var enemy = Enemy.instance()
	enemy.position = positions[randi() % positions.size()] + Vector2(randf()*100, randf()*100).rotated(randf()*2*PI)
	add_child(enemy)
	num_enemies = 1 + floor(Global.score / 100)


func _on_Respawn_timeout():
	add_enemy()
	respawning = false
