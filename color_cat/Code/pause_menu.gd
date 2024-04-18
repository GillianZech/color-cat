extends CanvasLayer
@onready var scene_controller = get_parent()
@onready var hud = get_parent().get_node("HUD")
@onready var unpause_button = $Unpause
@onready var quit_to_title = $QuitToTitle
@onready var quit_and_close = $QuitAndClose

func unpause():
	hud.paused = false
	visible = false
	scene_controller.freeze = false
	hud.visible = true

func _on_unpause_pressed():
	unpause()

func _on_quit_to_title_pressed():
	visible = false
	scene_controller.music.stop()
	scene_controller.music.seek(0)
	scene_controller._update_scene("TitleScreen")

func _on_quit_and_close_pressed():
	get_tree().quit()

func _on_music_switch_toggled(toggled_on):
	if toggled_on:
		get_parent().get_parent().music.play()
	else:
		get_parent().get_parent().music.stop()
