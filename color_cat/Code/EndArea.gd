extends Area2D

@export var NEXT_LEVEL: String = "Level2"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$LaserSprite.play("idle")
	if Input.is_action_just_pressed("dev"): # Alt key
		_continue()

func _on_body_entered(_body):
	if visible:
		$AnimationPlayer.play("move")

func _continue():
	print("prev food: "+str(get_parent().get_node("Cat").PREV_FOOD_COUNT))
	
	get_parent().get_node("Cat").PREV_FOOD_COUNT = get_parent().get_node("Cat").FOOD_COUNT
	var p = get_parent().get_node("Cat").PREV_FOOD_COUNT
	var f = get_parent().get_node("Cat").FOOD_COUNT
	print("food this level: "+str(get_parent().get_node("Cat").FOOD_COUNT))
	print("updated prev food: "+str(get_parent().get_node("Cat").PREV_FOOD_COUNT))
	get_parent().get_parent()._update_scene(NEXT_LEVEL)
	$AudioStreamPlayer2D.play()
	get_parent().get_node("Cat")._reset()
	get_parent().get_node("Cat").PREV_FOOD_COUNT = f
	get_parent().get_node("Cat").FOOD_COUNT = 0
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "move":
		_continue()
