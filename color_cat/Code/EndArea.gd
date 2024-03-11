extends Area2D

@export var NEXT_LEVEL: String = "Level2"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$LaserSprite.play("idle")
	if Input.is_action_just_pressed("dev"): # Alt key
		get_parent().get_parent()._update_scene(NEXT_LEVEL)
		$AudioStreamPlayer2D.play()
		get_parent().get_node("Cat")._reset()
		#get_parent().get_node("Cat").FOOD_APPEARED = false
		#get_parent().get_node("Cat").DOORS_LOCKED = true
		

func _on_body_entered(body):
	if visible:
		visible = false
		get_parent().get_parent()._update_scene(NEXT_LEVEL)
		$AudioStreamPlayer2D.play()
		body._reset()
		#body.FOOD_APPEARED = false
		#body.DOORS_LOCKED = true
