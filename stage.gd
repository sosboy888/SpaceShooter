extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var is_game_over=false
var asteroid=preload("res://asteroid.tscn")
const SCREEN_WIDTH=320
const SCREEN_HEIGHT=180
var spawn_limit=false
var score=0
var device_index=0
func _ready():
	get_node("spawn_timer").connect("timeout",self,"_on_spawn_timer_timeout")
	get_node("player").connect("destroyed",self,"_on_player_destroyed")
	randomize()
	Input.connect("joy_connection_changed",self,"joy_connect")
	
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER) or is_game_over and Input.is_joy_button_pressed(device_index,0):
		get_tree().change_scene("res://stage.tscn")
func _on_player_destroyed():
	get_node("ui/retry").show()
	$AudioStreamPlayer.stop()
	is_game_over=true
func _on_spawn_timer_timeout():
	if not spawn_limit:
		var asteroid_instance=asteroid.instance()
		$spawn_timer.wait_time=$spawn_timer.wait_time*0.99
		asteroid_instance.position=Vector2(SCREEN_WIDTH+8,rand_range(0,SCREEN_HEIGHT))
		asteroid_instance.MOVE_SPEED=asteroid_instance.MOVE_SPEED+score
		asteroid_instance.connect("score",self,"_on_player_score")
	
		add_child(asteroid_instance)
	if $spawn_timer.wait_time==0.15:
		spawn_limit=true
func _on_player_score():
	score+=1
	get_node("ui/score").text="score:"+str(score)

func joy_connect(index,connect):
	if connect:
		device_index=index