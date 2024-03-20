extends Area2D

@export var NEXT_LEVEL: String = "Level2"

@onready var cat = get_parent().get_node("Cat")
@onready var hud = get_parent().get_parent().get_node("HUD")
var food = 0
var pfood = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$LaserSprite.play("idle")
	if Input.is_action_just_pressed("dev"): # Alt key
		_continue()

func _on_body_entered(_body):
	if visible:
		$AnimationPlayer.play("move")

func _continue():
	print("prev food: "+str(hud.food_count))
	hud.pfood_count = hud.food_count
	food = hud.food_count
	pfood = hud.food_count
	print("food this level: "+str(food))
	print("updated prev food: "+str(pfood))
	
	get_parent().get_parent()._update_scene(NEXT_LEVEL)
	$AudioStreamPlayer2D.play()
	cat._reset()
	
	hud.pfood_count = pfood
	hud.food_count = pfood
	hud.update_score(pfood, false)
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "move":
		_continue()
