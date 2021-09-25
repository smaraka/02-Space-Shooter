extends Node

var score = 0
var health = 100

var Score = null
var Health = null

func _unhandled_input(_event):
	if Input.is_action_pressed("menu"):
		get_tree().quit()
		

func update_score(s):
	Score = get_node_or_null("/root/Game/HUD_Container/HUD/Score")
	if Score != null:
		score += s
		Score.text = "Score: " + str(score)

func update_health(h):
	Health = get_node_or_null("/root/Game/HUD_Container/HUD/Health")
	health += h
	Health.text = "Health: " + str(health)
	if health <= 0:
		var _scene = get_tree().change_scene("res://Menu/Die.tscn")
