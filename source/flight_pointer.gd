extends Spatial
class_name FlightPointer

const DISTANCE := 512
const MOUSE_SENSITIVITY := 0.005

onready var viewport := get_viewport()
onready var camera := viewport.get_camera()


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	global_transform.origin = camera.global_transform.origin


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var movement = event.relative * MOUSE_SENSITIVITY
		rotate(camera.global_transform.basis.x, -movement.y)
		rotate(camera.global_transform.basis.y, -movement.x)


func get_point() -> Vector3:
	return global_transform.origin + global_transform.basis.z * DISTANCE
