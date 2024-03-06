extends Node


@onready var CURRENT_LEVEL = $Level1
@onready var CURRENT_LEVEL_NAME: String = "Level1"
@onready var NEXT_LEVEL
@onready var NEXT_LEVEL_NAME: String = "Level2"
@onready var RELOAD
@onready var ADVANCING: bool

@export var ANIM: AnimationPlayer

func _ready():
	pass
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("restart"):
		get_node("Restart").play()
		_update_scene(CURRENT_LEVEL_NAME)

func _update_scene(NEXT_DESTINATION_NAME):
	NEXT_LEVEL_NAME = NEXT_DESTINATION_NAME
	ADVANCING = true
	ANIM.play("fade_in")

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
			ANIM.play("fade_out")
	
