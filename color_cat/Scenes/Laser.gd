extends Area2D
@onready var LASER_SPRITE = $LaserSprite
@onready var cat = self.get_parent().get_parent().get_node("Cat")

func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	LASER_SPRITE.play("idle")

func _on_body_entered(_body):
	if visible:
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("move") # will be invisible at end of animation
		set_collision_layer_value(6, 0)
		set_collision_mask_value(1, 0)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "move":
		if cat.CURRENT_LASER < cat.LASER_COUNT-1:
			cat.CURRENT_LASER += 1
			get_parent().get_child(cat.CURRENT_LASER).visible = true
		else:
			get_parent().get_parent().get_node("EndArea").visible = true


# originally I made a timer for the exact length of the move animation,
# but using _on_animation_player_animation_finished made more sense.
# I saved this code here in case I want to make another timer elsewhere.

# (part of on_body_entered):
		#var timer : Timer = Timer.new()
		#add_child(timer)
		#timer.wait_time = 0.55
		#timer.autostart = false
		#timer.one_shot = true
		#timer.timeout.connect(_on_timer_timeout)
		#timer.start()
#func _on_timer_timeout():
	#if cat.CURRENT_LASER >= cat.LASER_COUNT - 1:
		#get_parent().get_parent().get_node("EndArea").visible = true
	#else:
		#cat.CURRENT_LASER += 1
		#get_parent().get_child(cat.CURRENT_LASER).visible = true


# my attempt at automating laser animations

#func _move(cat):
	#var animPlayer = AnimationPlayer.new()
	#add_child(animPlayer)
	#var lib : AnimationLibrary = AnimationLibrary.new()
	#var next = Animation.new()
	#lib.add_animation("next", next)
	#animPlayer.add_animation_library("lib", lib)
	#
	#
	#next.add_track(0)
	#next.length = 0.55
	#var path = String(self.get_path()) + ":position"
	#next.track_set_path(0, path)
	#next.track_insert_key(0, 0.0, 1)
	#next.track_insert_key(0, 100.0, 3)
	#next.track_insert_key(0, 200.0, 5)
	#next.track_insert_key(0, 300.0, 7)
	#animPlayer.play("next")



	#var animation_player = AnimationPlayer.new()
	#add_child(animation_player)
#
	#var animation = Animation.new()
	#animation_player.add_animation("move", animation)
#
	#var transform_track = Animation.Track.TYPE_TRANSFORM
	#var property_path = "global_position"
	#var track = animation.add_track(transform_track, property_path)
	#
	## Set the length of the animation
	#animation.set_length(2)
#
	## Add keyframes
	#track.add_key(0)
	#track.add_key(1)
	#track.add_key(2)
#
	## Set keyframe values
	#track.set_key_value(0, Vector2(0, 0))
	#track.set_key_value(1, Vector2(100, 0))
	#track.set_key_value(2, Vector2(200, 0))
