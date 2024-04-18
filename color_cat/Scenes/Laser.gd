extends Area2D
@onready var LASER_SPRITE = $LaserSprite
@onready var markers = get_parent().get_node("Markers") # just a node, not an array you can get size of
# get_children() gives array of positions (markers) that I'm getting the size of
@onready var markers_amount = get_parent().get_node("Markers").get_children().size()
@export var collision_scale = Vector2(8,8)
var current_marker = 0
var tween
var tween_speed = 0.5

func _ready():
	$CollisionShape2D.set_scale(collision_scale)
	

func _physics_process(_delta):
	LASER_SPRITE.play("idle")

func _on_body_entered(_body):
	$AudioStreamPlayer2D.play()
	tween = create_tween()
	if current_marker == markers_amount: # gone through all markers, now go to EndArea position
		var new_position = get_parent().get_node("EndArea").position
		tween.tween_property(self, "global_position", new_position, tween_speed).set_trans(Tween.EASE_OUT)
		tween.finished.connect(tween_finished) # links signal of tween finishing just like _on_body_entered
	else:
		var new_position = markers.get_child(current_marker).position
		# Tween the node's position from current to next position
		tween.tween_property(self, "global_position", new_position, tween_speed).set_trans(Tween.EASE_OUT)
		current_marker+=1

func tween_finished():
	get_parent().get_node("EndArea").visible = true
	visible = false



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
