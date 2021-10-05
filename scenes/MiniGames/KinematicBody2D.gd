extends KinematicBody2D


var atype = 'atypical'

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		print('moving right')
		move_and_slide(Vector2.RIGHT * 800)
	if Input.is_action_pressed("ui_left"):
		print('moving left')
		move_and_slide(Vector2.LEFT * 800)
