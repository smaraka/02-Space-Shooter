extends Node2D

const bullet = preload("res://Enemy_Bullet/Enemy_Bullet.tscn")
onready var shoot_timer = $Shoot
onready var rotater = $Rotation
const rotation_speed = 1
var shooter_timer = 0.09
var spawn_count = 5
const radius = 100
const placement = Vector2(500, -60)
var state = 0
var ocilState = 0
var i = 0
var moveState = 0


func _ready():
	var step = 2 * PI / spawn_count #radius conversion to each spot on a circle to fire
	#moveState = 1

	for i in range(spawn_count):
		var spawn = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn.position = pos
		spawn.rotation = pos.angle()
		rotater.add_child(spawn)
		
	shoot_timer.wait_time = shooter_timer


func _physics_process(_delta):
	position = placement
	if (moveState % 2 == 0 and moveState == 0):
		enter()
		shoot_timer.start()
	if (moveState % 2 == 0 and moveState != 0):
		mainMove()
	elif (moveState % 3 == 0  and moveState != 0):
		shake()
	elif(moveState % 5 == 0  and moveState != 0):
		shootMoment()
	
	

func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotation_speed + delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func _on_Shoot_timeout():
	for s in rotater.get_children():
		var myBullet = bullet.instance()
		get_tree().root.add_child(myBullet)
		myBullet.position = s.global_position
		myBullet.rotation = s.global_rotation
		
func shootMoment():
	enter()
	spawn_count = 1
	shooter_timer = 0.001
	
func shake():
	placement.y = 100
	spawn_count = 1
	shooter_timer = 0.008
	if(state == 0):
		placement.x += 10
	else:
		placement.x -= 10
	if(placement.x == 700):
		state = 1
	elif(placement.x == 300):
		state = 0


func enter():
	if(placement.y < 100):
		placement.y += 10
	else:
		placement.y += 0

func mainMove():
	if(placement.x < 1000):
		placement.x += 5
		spawn_count = 10
		shooter_timer = 0.05
	elif(placement.x == 1000):
		placement.x = 50
	


