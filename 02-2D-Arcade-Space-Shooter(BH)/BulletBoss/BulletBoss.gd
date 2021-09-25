extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const speed = 100 

func _process(delta):
	position += transform.x * speed * delta

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Kill_timeout() -> void:
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
