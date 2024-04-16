extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass

func _on_back_to_pause_menu_pressed():
	visible = false
	get_parent().unpause_button.visible = true
	get_parent().settings.visible = true
	get_parent().quit_to_title.visible = true
	get_parent().quit_and_close.visible = true

func _on_music_switch_toggled(toggled_on):
	if toggled_on:
		get_parent().get_parent().music.play()
	else:
		get_parent().get_parent().music.stop()
