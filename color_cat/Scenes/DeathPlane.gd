extends Area2D

@export var THIS_LEVEL: String = "Level1"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# When body passes through it, reset the level.
func _on_body_entered(body):	
	get_parent().get_parent()._update_scene(THIS_LEVEL)
	body.FOOD_APPEARED = false
	body.DOORS_LOCKED = true
	get_node("Death").play()
	body._reset()
