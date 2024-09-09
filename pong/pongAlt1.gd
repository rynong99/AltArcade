extends Node2D

# Member variables
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 150
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 200

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = $Left.get_texture().get_size()*2
func _process(delta):
	var ball_pos = $Ball.position
	var left_rect = Rect2( $Left.position - pad_size*0.5, pad_size )
	var right_rect = Rect2( $Right.position - pad_size*0.5, pad_size )
	ball_pos += direction * ball_speed * delta
	#Flip when hitting the roof or floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
	#Flip when hitting pads
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	#Check if Ball passes either paddle and reset:
	if (ball_pos.x < 0 or ball_pos.x > screen_size.x):
		ball_pos = screen_size*0.5
		ball_speed = INITIAL_BALL_SPEED
		direction = Vector2(-1, 0)
	#Update ball position:
	$Ball.position = ball_pos
	# Move left pad
	var left_pos = $Left.position

	if (left_pos.y > 0 and Input.is_action_pressed("LeftUp")):
		left_pos.y += -PAD_SPEED * delta
	elif left_pos.y < screen_size.y:
			left_pos.y += PAD_SPEED * delta

	$Left.position = left_pos

	# Move right pad
	var right_pos = $Right.position

	if (right_pos.y > 0 and Input.is_action_pressed("RightUp")):
		right_pos.y += -PAD_SPEED * delta
	elif right_pos.y < screen_size.y:
			right_pos.y += PAD_SPEED * delta

	$Right.position = right_pos
