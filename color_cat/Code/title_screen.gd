extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass


func _on_start_button_pressed():
	get_parent()._update_scene("Level1")
	#get_parent().music.play()


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_level_6_pressed():
	get_parent()._update_scene("Level6")
	
	pass # Replace with function body.
