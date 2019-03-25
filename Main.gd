extends Node

export (PackedScene) var Mob
var score
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()


func _on_ScoreTimer_timeout():
	score+=1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	# gets random position along path2d
	$MobPath/MobSpawnLocation.set_offset(randi())
	# instantiates mob scene and adds it to the main scene
	var mob = Mob.instance()
	add_child(mob)
	
	# gets mob spawn location rotation perpendicular
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2 
	mob.position = $MobPath/MobSpawnLocation.position
	
	# adds -45 to 45 º of randomness 
	direction += rand_range(-PI / 4, PI / 4)
	
	# assigns direction
	mob.rotation = direction
	
	# sets velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
