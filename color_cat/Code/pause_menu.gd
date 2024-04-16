extends CanvasLayer
@onready var scene_controller = get_parent()
@onready var hud = get_parent().get_node("HUD")
@onready var settings_menu = $SettingsMenu
@onready var unpause_button = $Unpause
@onready var settings = $Settings
@onready var quit_to_title = $QuitToTitle
@onready var quit_and_close = $QuitAndClose


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass

func unpause():
	hud.paused = false
	visible = false
	scene_controller.freeze = false
	hud.visible = true

func _on_unpause_pressed():
	unpause()

func _on_settings_pressed():
	unpause_button.visible = false
	settings.visible = false
	quit_to_title.visible = false
	quit_and_close.visible = false
	settings_menu.visible = true

func _on_quit_to_title_pressed():
	visible = false
	scene_controller.music.stop()
	scene_controller.music.seek(0)
	scene_controller._update_scene("TitleScreen")

func _on_quit_and_close_pressed():
	get_tree().quit()
