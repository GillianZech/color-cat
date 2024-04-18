extends Control

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	pass

func _on_start_button_pressed():
	get_parent()._update_scene("Level1")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_levels_pressed():
	$LevelButtons.visible = true
	$ControlsText.visible = false

func _on_level_1_pressed():
	get_parent()._update_scene("Level1")

func _on_level_2_pressed():
	get_parent()._update_scene("Level2")

func _on_level_3_pressed():
	get_parent()._update_scene("Level3")

func _on_level_4_pressed():
	get_parent()._update_scene("Level4")

func _on_level_5_pressed():
	get_parent()._update_scene("Level5")

func _on_level_6_pressed():
	get_parent()._update_scene("Level6")

func _on_controls_button_pressed():
	$ControlsText.visible = true
	$LevelButtons.visible = false
