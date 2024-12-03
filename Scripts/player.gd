class_name Player extends RigidBody3D

@onready var pivot: Node3D = $Pivot
@onready var camera_3d: Camera3D = $Pivot/Camera3D

@export var horizontalRotationSensitivity : int = 5
@export var rolling_force: int = 20
@export var maxVerticalTilt := 15
@export var minVerticalTilt := -30
@export var maxHorizontalTilt := 50
@export var minHorizontalTilt := -50
@export var cameraSensitivity := 1.5

var defaultVerticalTilt
var defaultHorizontalTilt
var newVerticalTilt
var newHorizontalTilt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot.top_level = true
	defaultVerticalTilt = pivot.rotation.x
	defaultHorizontalTilt = camera_3d.rotation.z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	
	pivot.global_transform.origin = lerp(pivot.global_transform.origin,self.global_transform.origin,0.51)
	
	#var axis_vector = Input.get_vector("roll_left","roll_right","roll_up","roll_back")
	#if axis_vector.length() != 0:
		#pivot.rotate_y(deg_to_rad(-axis_vector.x * 1.5))
		#camera_3d.rotate_x(deg_to_rad(-axis_vector.y * 1.5))
		#camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(minHorizontalTilt), deg_to_rad(maxHorizontalTilt))

	
	if Input.get_axis("roll_up","roll_back") != 0:
		angular_velocity += rolling_force * _delta * (Input.get_axis("roll_up","roll_back")) * pivot.transform.basis.x.normalized()
		newVerticalTilt = -remap(deg_to_rad(	Input.get_axis("roll_up", "roll_back")), 0, 1, 0, 360)
		pivot.rotation.x = lerp(pivot.rotation.x,clamp(newVerticalTilt, deg_to_rad(minVerticalTilt), deg_to_rad(maxVerticalTilt)), 0.15)
		if Input.get_axis("roll_up","roll_back") > 0:
			var pivotRotation = Input.get_axis("roll_up","roll_back")
			pivot.rotate_y(deg_to_rad(-pivotRotation * cameraSensitivity * 2))
	else:
		pivot.rotation.x = lerp(pivot.rotation.x, defaultVerticalTilt,0.15)
		
	if Input.get_axis("roll_left","roll_right") != 0:
		var pivotRotation = Input.get_axis("roll_left","roll_right")
		angular_velocity -= rolling_force * _delta * (Input.get_axis("roll_left","roll_right")) * pivot.transform.basis.z.normalized()
		newHorizontalTilt = remap(deg_to_rad(Input.get_axis("roll_left", "roll_right")), 0, 1, 0, 360)
		camera_3d.rotation.z = lerp(camera_3d.rotation.z,clamp(newHorizontalTilt, deg_to_rad(minHorizontalTilt), deg_to_rad(maxHorizontalTilt)), 0.15)
		pivot.rotate_y(deg_to_rad(-pivotRotation * cameraSensitivity))
		

	else:
		camera_3d.rotation.z = lerp(camera_3d.rotation.z, defaultHorizontalTilt,0.15)
		
	#if Input.is_action_pressed("ui_up"):
		#angular_velocity.x -= rolling_force * _delta
		#
	#elif Input.is_action_pressed("ui_down"):
		#angular_velocity.x += rolling_force * _delta
		#
	#if Input.is_action_pressed("ui_left"):
		#angular_velocity.z += rolling_force * _delta
		#
	#elif Input.is_action_pressed("ui_right"):
		#angular_velocity.z -= rolling_force * _delta
