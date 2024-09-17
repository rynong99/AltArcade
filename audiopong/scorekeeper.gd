extends Node2D

@onready var player_score_label = $PlayerScore
@onready var CPU_score_label = $CPUScore
var player_score = 0
var CPU_score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_score_label.text = str(player_score)
	CPU_score_label.text = str(CPU_score)

func _on_top_area_entered(area: Area2D) -> void:
	player_score += 1
	$PlayArea/Top/Score.play()
	reset() # Replace with function body.


func _on_bottom_area_entered(area: Area2D) -> void:
	CPU_score += 1 # Replace with function body.
	$PlayArea/Bottom/Loss.play()
	reset()
	
func reset():
	$PlayArea.position.x = 0;
	$PlayArea/Ball.position.x = 600;
	$PlayArea/Ball.position.y = 800;
	$PlayArea/Ball.speed = Vector2(100,100);
	$PlayArea/Paddle.position.x = 600;
	
