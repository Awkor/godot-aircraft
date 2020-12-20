extends TextureRect

export (NodePath) var flight_pointer_path

onready var flight_pointer: FlightPointer = get_node(flight_pointer_path)
onready var viewport := get_viewport()
onready var camera := viewport.get_camera()


func _process(delta: float) -> void:
	var point: Vector3 = flight_pointer.get_point()
	var screen_position: Vector2 = camera.unproject_position(point)
	rect_position = screen_position - rect_size / 2
