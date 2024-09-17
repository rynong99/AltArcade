extends Area2D

@export var speed = Vector2(100,100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(speed*delta)
	if position.y >= 1200 or position.y <= 0:
		speed.y *= -1
	if position.x >= 800 or position.x <= 0:
		speed.x *= -1



func _on_paddle_area_entered(area: Area2D) -> void:
	$Hit.play()
	print("boing")
	speed.y *= -1.1
