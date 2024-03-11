extends Area2D

@export var NEXT_LEVEL: String = "Level2"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$LaserSprite.play("idle")
	if Input.is_action_just_pressed("dev"): # Alt key
		_continue()
		#get_parent().get_parent()._update_scene(NEXT_LEVEL)
		#$AudioStreamPlayer2D.play()
		#get_parent().get_node("Cat")._reset()

func _on_body_entered(_body):
	if visible:
		visible = false
		_continue()
		#get_parent().get_parent()._update_scene(NEXT_LEVEL)
		#$AudioStreamPlayer2D.play()
		#body._reset()

func _continue():
	get_parent().get_parent()._update_scene(NEXT_LEVEL)
	$AudioStreamPlayer2D.play()
	get_parent().get_node("Cat")._reset()
