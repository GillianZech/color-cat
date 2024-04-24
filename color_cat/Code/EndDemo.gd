extends Node2D
@onready var hud = get_parent().get_node("HUD")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Congratulations!\nYou collected "+str(hud.pfood_count+hud.food_count)+" food!"
	hud.pfood_count = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass
