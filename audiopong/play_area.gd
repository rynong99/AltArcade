extends Area2D

var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("FarLeft"):
		global_position.x = 500
	elif Input.is_action_pressed("Left"):
		global_position.x = 300
	elif Input.is_action_pressed("Center"):
		global_position.x = 200
	elif Input.is_action_pressed("FarRight"):
		global_position.x = -100
	elif Input.is_action_pressed("Right"):
		global_position.x = 100

	
	$Paddle.position.x = $Ball.position.x #Cheater AI Test Code
