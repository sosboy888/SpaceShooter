extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal destroyed
var shot_scene=preload("res://shot.tscn")
var explosion_scene=preload("res://explosion.tscn")
var MOVE_SPEED=250
const SCREEN_WIDTH=320
const SCREEN_HEIGHT=180
var can_shoot=true
var device_index=0
func _ready():
	Input.connect("joy_connection_changed",self,"joy_connect")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var input_dir=Vector2()
	
	if position.x>SCREEN_WIDTH:
		position=SCREEN_WIDTH
	elif position.x<0.0+9.0:
		position.x=9.0
	elif position.y>SCREEN_HEIGHT:
		position.y=SCREEN_HEIGHT
	elif position.y<0.0:
		position.y=0.0
	if Input.is_key_pressed(KEY_LEFT) or Input.is_joy_button_pressed(device_index, 14):
		input_dir.x=-1.0
	elif Input.is_key_pressed(KEY_RIGHT)or Input.is_joy_button_pressed(device_index,15):
		input_dir.x=1.0
	elif Input.is_key_pressed(KEY_UP) or Input.is_joy_button_pressed(device_index,12):
		input_dir.y=-1.0
	elif Input.is_key_pressed(KEY_DOWN) or Input.is_joy_button_pressed(device_index,13):
		input_dir.y=1.0
	if Input.is_key_pressed(KEY_SPACE) and can_shoot or Input.is_joy_button_pressed(device_index,0) and can_shoot:
		var stage_node=get_parent()
		var shot_instance=shot_scene.instance()
		shot_instance.position=position+Vector2(9,-5)
		stage_node.add_child(shot_instance)
		var shot_instance2=shot_scene.instance()
		shot_instance2.position=position+Vector2(9,5)
		stage_node.add_child(shot_instance2)
		can_shoot=false
		get_node("reload_timer").start()
	position+=(delta*MOVE_SPEED)*input_dir
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

func _on_reload_timer_timeout():
	can_shoot=true
	
	pass # replace with function body


func _on_player_area_entered(area):
	if area.is_in_group("asteroid"):
		
		var explosion_instance=explosion_scene.instance()
		explosion_instance.position=position
		queue_free()
		get_parent().add_child(explosion_instance)
		
		emit_signal("destroyed")
	pass # replace with function body
func joy_connect(index,connect):
	if connect:
		device_index=index