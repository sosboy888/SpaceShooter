extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SCREEN_WIDTH=320
const SCREEN_HEIGHT=180
var MOVE_SPEED=500.0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	position+=Vector2(MOVE_SPEED*delta,0.0)
	if position.x>SCREEN_WIDTH+8:
		queue_free()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


func _on_shot_area_entered(area):
	if area.is_in_group("asteroid"):
		queue_free() # replace with function body
