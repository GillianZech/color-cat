extends Area2D

@onready var FOOD_SPRITE = $FoodSprite
@export var COLLECTED = false
@onready var hud = get_parent().get_parent().get_parent().get_node("HUD")

func _ready():
	$CollectSound.set_volume_db(-20)

func _physics_process(_delta):
	FOOD_SPRITE.play("idle")
	
func _on_body_entered(_body):
	$AnimationPlayer.play("collect") # will be invisible at end of animation
	$CollectSound.play()
	visible = true
	hud.food_count+=1
	hud.update_score(hud.food_count, true)
	set_collision_layer_value(4, 0)
	set_collision_mask_value(1, 0)
	COLLECTED = true
