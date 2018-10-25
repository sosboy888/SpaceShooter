extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SCREEN_WIDTH=320
var scroll_speed=30.0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	position+=Vector2(-scroll_speed*delta,0.0)
	if position.x<=-SCREEN_WIDTH:
		position.x+=SCREEN_WIDTH
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
