extends Area2D

# When body passes through it, reset the level.
func _on_body_entered(body):
	body._die()
	
