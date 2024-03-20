extends Area2D

@onready var FOOD_SPRITE = $FoodSprite
@export var COLLECTED = false

func _ready():
	$CollectSound.set_volume_db(-20)

func _physics_process(_delta):
	FOOD_SPRITE.play("idle")
	
func _on_body_entered(body):
	$AnimationPlayer.play("collect") # will be invisible at end of animation
	$CollectSound.play()
	visible = true
	body.FOOD_COUNT+=1
	get_parent().get_parent().get_parent().get_node("HUD").update_score(body.FOOD_COUNT, true)
	#print("Food collected! You have collected "+str(body.FOOD_COUNT)+" can(s) of food.")
	set_collision_layer_value(4, 0)
	set_collision_mask_value(1, 0)
	COLLECTED = true
