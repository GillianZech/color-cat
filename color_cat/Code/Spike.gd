extends Area2D

#@export var THIS_LEVEL: String = "Level1"

func _on_body_entered(body):
	body._die()
	
	#get_parent().get_parent().get_parent()._update_scene(THIS_LEVEL)
	#body.FOOD_APPEARED = false
	#body.DOORS_LOCKED = true
	#get_node("Death").play()
	#body._reset()
