extends RigidBody2D

var screensize = Vector2.ZERO

func _ready():
	screensize = get_viewport().size

func _integrate_forces(state):
	var t = state.get_transform()
	t.origin.x = wrapf(t.origin.x,0,screensize.x)
	t.origin.y = wrapf(t.origin.y,0,screensize.y)
	state.set_transform(t)
