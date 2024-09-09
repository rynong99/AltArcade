extends Node2D

# Member variables
var rng = RandomNumberGenerator.new()
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)
var target_pos

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 120
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 200

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = $Left.get_texture().get_size()*3
	target_pos = rng.randf_range(0, screen_size.y)
func _process(delta):
	var ball_pos = $Ball.position
	var left_rect = Rect2( $Left.position - pad_size*0.5, pad_size )
	var right_rect = Rect2( $Right.position - pad_size*0.5, pad_size )
	var left_pos = $Left.position
	var right_pos = $Right.position
	ball_pos += direction * ball_speed * delta
	#Flip when hitting the roof or floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
		$Ball/Hit.play()
	#Flip when hitting pads
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
		$Ball/Hit.play()
	#Check if Ball passes either paddle and reset:
	if (ball_pos.x < 0 or ball_pos.x > screen_size.x):
		ball_pos = screen_size*0.5
		left_pos.y = screen_size.y*0.5
		right_pos.y = screen_size.y*0.5 #reset paddle positions
		ball_speed = INITIAL_BALL_SPEED
		direction = Vector2(-1, 0)
	#Update ball position:
	$Ball.position = ball_pos
	# Move left pad
	if (left_pos.y > 0 and Input.is_action_pressed("LeftUp")):
		left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < screen_size.y and Input.is_action_pressed("LeftDown")):
		left_pos.y += PAD_SPEED * delta

	$Left.position = left_pos

	# Move right pad
	#get a new position to move to
	if (right_pos.y > target_pos):
		right_pos.y += -PAD_SPEED * delta
		if (right_pos.y <= target_pos):
			print('Arrived at target.')
			target_pos = rng.randf_range(0, screen_size.y)
			print(target_pos)
	if (right_pos.y < target_pos):
		right_pos.y += PAD_SPEED * delta
		if (right_pos.y >= target_pos):
			print('Arrived at target.')
			target_pos = rng.randf_range(0, screen_size.y)
			print(target_pos)

	#if (right_pos.y > 0 and Input.is_action_pressed("RightUp")):
		#right_pos.y += -PAD_SPEED * delta
	#if (right_pos.y < screen_size.y and Input.is_action_pressed("RightDown")):
		#right_pos.y += PAD_SPEED * delta

	$Right.position = right_pos
