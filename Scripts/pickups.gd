extends Node3D

@export var value: int = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
 

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		queue_free()
