extends Control

@onready var levels_on = false
@onready var controls_on = false

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	$CatSprite.play("idle")
	$BucketSprite.play("idle")
	$BucketSprite2.play("idle")
	$BucketSprite3.play("idle")
	$LaserSprite.play("idle")
	$FoodSprite.play("idle")

func _on_start_button_pressed():
	get_parent()._update_scene("Level1")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_levels_pressed():
	if not levels_on:
		$LevelButtons.visible = true
		$ControlsText.visible = false
		levels_on = true
	else:
		$LevelButtons.visible = false
		levels_on = false
	controls_on = false

func _on_controls_button_pressed():
	if not controls_on:
		$ControlsText.visible = true
		$LevelButtons.visible = false
		controls_on = true
	else:
		$ControlsText.visible = false
		controls_on = false
	levels_on = false

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

func _on_level_7_pressed():
	get_parent()._update_scene("Level7")

func _on_level_8_pressed():
	get_parent()._update_scene("EndDemo")
