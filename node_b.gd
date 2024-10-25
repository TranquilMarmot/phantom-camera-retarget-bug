class_name NodeB
extends RigidBody3D

var driving: bool = false

@onready var phantom_camera: PhantomCamera3D = $PhantomCamera3D


func _process(_delta: float) -> void:
	if not driving:
		return

	var movement := Input.get_vector(&"ui_left", &"ui_right", &"ui_up", &"ui_down")
	linear_velocity = Vector3(movement.x, 0, movement.y) * 10
