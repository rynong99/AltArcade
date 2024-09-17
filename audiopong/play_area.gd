extends Area2D

var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("FarLeft"):
		if global_position.x < 500:
			global_position.x += speed * delta * 7
		else:
			global_position.x = 500
	elif Input.is_action_pressed("Left"):
		if global_position.x < 300:
			global_position.x += speed * delta * 5
		elif global_position.x > 300:
			global_position.x -= speed * delta * 5
		else:
			global_position.x = 300
	elif Input.is_action_pressed("Center"):
		global_position.x = 200
	elif Input.is_action_pressed("FarRight"):
		if global_position.x > -100:
			global_position.x -= speed * delta * 5
		else:
			global_position.x = -100
	elif Input.is_action_pressed("Right"):
		if global_position.x > 100:
			global_position.x -= speed * delta * 5
		elif global_position.x < 100:
			global_position.x += speed * delta * 5
		else:
			global_position.x = 100

	
	#$Paddle.position.x = $Ball.position.x #Cheater AI Test Code
	var right_pos = $Paddle.position
	var ball_pos = $Ball.position
	if (right_pos.x > ball_pos.x):
		right_pos.x += -speed * delta * 0.5
	if (right_pos.x < ball_pos.x):
		right_pos.x += speed * delta * 0.5
	#right_pos.y = ball_pos.y #Cheater AI
	#if (right_pos.y > 0 and Input.is_action_pressed("RightUp")):
		#right_pos.y += -PAD_SPEED * delta
	#if (right_pos.y < screen_size.y and Input.is_action_pressed("RightDown")):
		#right_pos.y += PAD_SPEED * delta

	$Paddle.position = right_pos
