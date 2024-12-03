extends Node3D

@export var distanceBetweenSpawns = 1.0
@export var pickup : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Path3D:
			spawn(child)

		
func getPosition():
	pass

	
func _process(_delta: float) -> void:
	pass

func spawn(path : Path3D):
	
	
	var pathLength: float = path.curve.get_baked_length()
	var count = floor(pathLength/distanceBetweenSpawns)
	
	for i in range (0, count):
		var itemInstance = pickup.instantiate()
		var curveDistance = distanceBetweenSpawns * i
		var itemPosition = path.curve.sample_baked(curveDistance, true)
		itemInstance.position = itemPosition
		get_tree().get_root().get_node("Game/LevelPickUps").add_child(itemInstance)
