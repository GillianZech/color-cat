extends Area2D
@onready var LASER_SPRITE = $LaserSprite



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	_animate()
	
func _animate():
	LASER_SPRITE.play("idle")

func _on_body_entered(_body):
	if visible:
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("move") # will be invisible at end of animation
		#visible = false
		set_collision_layer_value(6, 0)
		set_collision_mask_value(1, 0)
		# wait for a 0.5 second timer somehow
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.55
		timer.autostart = false
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		timer.start()
		#if body.CURRENT_LASER >= 3:
			#body.get_parent().get_node("EndArea").visible = true
		#else:
			#body.CURRENT_LASER += 1
			#body.get_parent().get_node("Lasers").get_child(body.CURRENT_LASER).visible = true

func _on_timer_timeout():
	if get_parent().get_parent().get_node("Cat").CURRENT_LASER >= 3:
		get_parent().get_parent().get_node("EndArea").visible = true
	else:
		get_parent().get_parent().get_node("Cat").CURRENT_LASER += 1
		get_parent().get_child(get_parent().get_parent().get_node("Cat").CURRENT_LASER).visible = true
