extends Node


@onready var CURRENT_LEVEL = $Level1
@onready var CURRENT_LEVEL_NAME: String = "Level1"
@onready var NEXT_LEVEL
@onready var NEXT_LEVEL_NAME: String = "Level2"
@onready var RELOAD
@onready var ADVANCING: bool
@onready var hud = get_node("HUD")
var freeze = false

@export var ANIM: AnimationPlayer

func _ready():
	pass
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("restart"): # R key
		# Restart the current level
		get_node("Restart").play()
		_restart()


func _update_scene(NEXT_DESTINATION_NAME):
	NEXT_LEVEL_NAME = NEXT_DESTINATION_NAME
	# make HUD invisible
	hud.visible = false
	ADVANCING = true
	freeze = true
	ANIM.play("fade_in")

func _restart():
	# make HUD invisible
	hud.visible = false
	ADVANCING = false
	freeze = true
	ANIM.play("fade_in")
	#_update_scene(CURRENT_LEVEL_NAME)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		if ADVANCING == true:
			NEXT_LEVEL = load("res://Scenes/" + NEXT_LEVEL_NAME + (".tscn")).instantiate()
			NEXT_LEVEL.visible = false
			add_child(NEXT_LEVEL)
			CURRENT_LEVEL.queue_free() #deletes current level
			CURRENT_LEVEL = NEXT_LEVEL
			CURRENT_LEVEL_NAME = NEXT_LEVEL_NAME
			CURRENT_LEVEL.visible = true
			hud.pfood_count = hud.food_count
			ANIM.play("fade_out")
		else:
			RELOAD = load("res://Scenes/" + CURRENT_LEVEL_NAME + (".tscn")).instantiate()
			RELOAD.visible = false
			add_child(RELOAD)
			CURRENT_LEVEL.queue_free()
			CURRENT_LEVEL = RELOAD
			CURRENT_LEVEL.visible = true
			hud.food_count = hud.pfood_count
			hud.update_score(false)
			ANIM.play("fade_out")
	if anim_name == "fade_out": #do these things once the level fully loads back in
		# make HUD visible
		hud.visible = true
		freeze = false
