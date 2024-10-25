class_name NodeA
extends RigidBody3D

@export var node_b: Node3D

## Original parent of visual representation of this character.
var visuals_original_parent: Node3D

## Here this represents the "visuals" of a character.
## In practice, this will be a child of a "smoothing" node
## (https://github.com/lawnjelly/smoothing-addon)
## At least until Godot 4.4 is released.
@onready var visuals: MeshInstance3D = $MeshInstance3D

@onready var phantom_camera: PhantomCamera3D = $PhantomCamera3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if node_b.driving:
		return

	var movement := Input.get_vector(&"ui_left", &"ui_right", &"ui_up", &"ui_down")
	linear_velocity = Vector3(movement.x, 0, movement.y) * 10


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed(&"ui_accept"):
		if not node_b.driving:
			# reparent the visuals to be inside the "car"
			# this way, the character is "driving"
			visuals_original_parent = visuals.get_parent()
			visuals.reparent(node_b)
			visuals.global_position = node_b.global_position

			phantom_camera.priority = 0
			node_b.phantom_camera.priority = 100

			node_b.driving = true
		else:
			# reparent the character back to their original parent
			visuals.global_position = visuals_original_parent.global_position
			visuals.reparent(visuals_original_parent)
			visuals_original_parent = null

			phantom_camera.priority = 100
			node_b.phantom_camera.priority = 0

			node_b.driving = false

			# WORKAROUND - uncomment to "fix" bug
			# phantom_camera.follow_target = null
			# phantom_camera.follow_target = visuals

		get_viewport().set_input_as_handled()

	elif event.is_action_pressed(&"ui_cancel"):
		get_tree().quit()
